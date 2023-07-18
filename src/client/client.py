import json
from io import StringIO
import asyncio
from websockets.client import connect

import src.chess.board as board
import src.chess.move_encoding as menc

FIELD_ARRAY = board.FIELD_ARRAY

PORT = "8025"

# create json login object and try to log in
MSG_TYPE = {
  "LOGIN" : 0,

  "GET_GAMES" : 1,
  "CREATE_GAME" : 2,
  "JOIN_GAME" : 3,

  "MOVE" : 4,
  "DATABASE" : 5,

  "START_TOURNAMENT" : 6,
  "GET_PLAYERS" : 7,
  "GAME_STARTED" : 8,

  "Error" : -1,
  "ILLEGAL_MOVE" : -2,
  "NOT_IMPLEMENTED" : -3,
  "INVALID_REQUEST" : -4,
  "UNAUTHORIZED" : -5,
  "FULL" : -6,
  "NOT_FOUND" : -7,
}

def forceGet(array, i):
    length = len(array)
    return None if i >= length else array[i]

def msg_login(userName):
    load = {}

    load["type"] = MSG_TYPE["LOGIN"]
    load["username"] = userName

    return json.dumps(load)

def msg_get_games():
    load = {}
    load["type"] = MSG_TYPE["GET_GAMES"]

    return json.dumps(load)

def msg_create_game(userName, playerID, timeout=None, gameRetentionTime=None):
    load = {}
    load["type"] = MSG_TYPE["CREATE_GAME"]
    load["username"] = userName
    load["playerID"] = playerID

    if timeout:
        load["timeout"] = timeout

    if gameRetentionTime:
        load["gameRetentionTime"] = gameRetentionTime

    return json.dumps(load)

def msg_join_game(userName, playerID, gameID):
    load = {}

    load["type"] = MSG_TYPE["JOIN_GAME"]
    load["username"] = userName
    load["playerID"] = playerID
    load["joinAsPlayer"] = {
        "PLAYER": 1
    }
    load["gameID"] = gameID

    return json.dumps(load)

def msg_move(userName, playerID, gameID, move, stamp):
    load = {}

    load["type"] = MSG_TYPE["MOVE"]
    load["username"] = userName
    load["playerID"] = playerID
    load["gameID"] = gameID
    load["move"] = move
    load["stamp"] = stamp

    return json.dumps(load)

def msg_start_game(ticks, gameTimeout, gameRetentionTime):
    load = {
        "message": {}
    }

    load["type"] = MSG_TYPE["START_TOURNAMENT"]
    load["ticks"] = ticks
    load["gameTimeout"] = gameTimeout
    load["auth"] = "PawnAttack"
    

    if gameRetentionTime:
        load["gameRetentionTime"] = gameRetentionTime

    return json.dumps(load)

# def messageHandler(msg):
#     result = StringIO(json.loads(msg))

#     match result:
#         # Login
#         if cmd == 0:
#             return 
#         # Get games
#         if cmd == 1:
#             return 
#         # create game
#         if cmd == 2:
#             return 
#         # Join game
#         if cmd == 3:
#             return 
#         # Move
#         if cmd == 4:
#             return 
#         # Database
#         if cmd == 5:
#             return 
#         # Start tournament
#         if cmd == 6:
#             return 
#         # Get players
#         if cmd == 7:
#             return 
#         # Game started
#         if cmd == 8:
#             return 
#         # Error
#         if cmd == -1:
#             return 
#         # Illegal Move
#         if cmd == -2:
#             return 
#         # Not implemented
#         if cmd == -3:
#             return 
#         # invalid request
#         if cmd == -4:
#             return 
#         # unauthorized
#         if cmd == -5:
#             return 
#         # full
#         if cmd == -6:
#             return 
#         # not found
#         if cmd == -7:
#             return 
#         # 
#         if cmd == _: 
#             return "Unhandled msg if cmd =="

async def hello(websocket):
    await websocket.send("Hello world!")
    message = await websocket.recv()
    print(f"Received: {message}")

async def login(websocket, userName):
    load = msg_login(userName)

    await websocket.send(load)
    raw = await websocket.recv()
    res = json.load(StringIO(raw))

    print("Response: ", res)

    if res["type"] == -1:
        print("A user with your name is already logged in")
        return [], False 

    elif res["type"] != 0:
        print("Error in login.")
        return [], False 

    return res, True

async def getGames(websocket):
    load = msg_get_games()

    await websocket.send(load)
    raw = await websocket.recv()
    res = json.load(StringIO(raw))

    print("Response: ", res)

    if res["type"] != 1:
        print("Error in getGames.")
        return [], False 

    return res, True

async def createGame(websocket, userName, playerID):
    if userName != "PawnAttack":
        print("Only admins are allowed to start the game.")
        return [], False

    load = msg_create_game(userName, playerID)

    await websocket.send(load)
    raw = await websocket.recv()
    res = json.load(StringIO(raw))

    print("Response: ", res)

    if res["type"] != 2:
        print("Error in createGame.")
        return [], False 

    return res, True

async def joinGame(websocket, userName, playerID, gameID):
    load = msg_join_game(userName, playerID, gameID)

    await websocket.send(load)
    raw = await websocket.recv()
    res = json.load(StringIO(raw))

    print("Response: ", res)

    if res["type"] != 3:
        print("Error in joinGame.")
        return [], False 

    return res, True

async def startGame(websocket, userName, ticks, gameTimeout, gameRetentionTime=None):
    if userName != "PawnAttack":
        print("Only admins are allowed to start the game.")
        return [], False

    load = msg_start_game(ticks, gameTimeout, gameRetentionTime)

    await websocket.send(load)
    raw = await websocket.recv()
    res = json.load(StringIO(raw))

    print("Response: ", res)
    
    if res["type"] != 6:
        print("Error in joinGame.")
        return [], False 

    return res, True

async def move(websocket, userName, playerID, gameID, move, stamp):
    load = msg_move(userName, playerID, gameID, move, stamp)

    await websocket.send(load)
    raw = await websocket.recv()
    res = json.load(StringIO(raw))

    print("MOVE RESPONSE: ", res)

    if res["type"] != 4:
        print("Error in move.")
        return [], False 

    return res, True

async def gameLoop2(websocket, userName, playerID, gameID):
    login = False
    newBoard = board.Board()
    res = None

    while(True):
        if not login:
            raw = await websocket.recv()
            res = json.load(StringIO(raw))

            print("GAME START: ", res)

            if res["type"] != 8:
                print("Failed to start game.")
                return [], False
            
            login = True
            continue



        if res["over"] == True:
            print("Game is over.")
            return [], True

        if res["currentPlayer"]["playerID"] == playerID:
            newBoard.fenGameSetup(res["fen"])
            bestMove = newBoard.doSearch()
            start, target, piece, promoted, capture, doublePush, enpassant, castling = menc.decode(bestMove)

            moveString = "" + FIELD_ARRAY[start] + FIELD_ARRAY[target]
            print("MOVE USED: ", moveString)
            res, ok = await move(websocket, userName, playerID, gameID, moveString)
            if not ok:
                print("Failed to make move")
                return [], False
        elif res["currentPlayer"]["playerID"] != playerID:
            raw = await websocket.recv()
            res = json.load(StringIO(raw))

            print(res)

async def gameLoop(websocket, userName, playerID, gameID):
    turn = 0
    colorObj = {}
    reverse = {}
    newBoard = board.Board()
    res = None

    # initial message after login
    raw = await websocket.recv()
    res = json.load(StringIO(raw))
    
    print(res)

    player1 = res["activePlayerList"][0]["playerID"]
    player2 = res["activePlayerList"][1]["playerID"]
    
    colorObj[player1] = 0
    colorObj[player2] = 1

    reverse[0] = player1
    reverse[1] = player2

    while(True):
        
        # 
        if turn == colorObj[playerID]:
            
            newBoard.fenGameSetup(res["fen"])
            bestMove = newBoard.doSearch()
            start, target, piece, promoted, capture, doublePush, enpassant, castling = menc.decode(bestMove)

            moveString = "" + FIELD_ARRAY[start] + FIELD_ARRAY[target]
            print("MOVE USED: ", moveString)
            res, ok = await move(websocket, userName, playerID, gameID, moveString, colorObj[playerID])
            if not ok:
                print("Failed to make move")
                return [], False
            
            turn = (turn + 1) % 2
            
        else: 
            raw = await websocket.recv()
            res = json.load(StringIO(raw))

            if res["check"] or res["stalemate"]:
                winner = reverse[turn]
                print(f"Player {winner} won.")
                return [], True

            if res["draw"]:
                print(f"Draw!")
                return [], True

            if res["type"] == 4:
                turn = (res["stamp"] + 1) % 2

            print(res)


            

async def parseGame():
    # user input cycle 
        # login if not logged in
        # create or join game 
        # join game if not joined 
    # wait for players full (manual)
    # start tournament (manual)
    # move loop 

    async with connect(f"ws://localhost:{PORT}") as websocket:
        if websocket.connection_lost == True:
            print("Failed to connect.")
            return

        # login if not logged in
        # create or join game
        userName = None
        playerID = None
        gameID = None
        games = []

        print("Please type a command:")

        # input loop
        while(True):
            ui = input()
            cmd_List = ui.split()
            cmd = forceGet(cmd_List, 0)

            # match cmd:

            if cmd == "login":
                if playerID != None:
                    print(f"You're already logged in. Name: {userName}, ID: {playerID}")
                    continue

                check_name = forceGet(cmd_List, 1)
                if not check_name:
                    print("Please provide a username as the second cmd argument.")
                    continue

                if check_name == "admin":
                    userName = "PawnAttack"
                else:
                    userName = " ".join(cmd_List[1:])


                res_login, ok = await login(websocket, userName)
                if not ok: 
                    continue

                playerID = res_login["playerID"]

                print(f"Logged in as {playerID}")

            elif cmd == "logout":
                userName = None
                playerID = None
                print(f"Logged out.")

            elif cmd == "playerid":
                print(f"Your playerID: ", playerID)

            elif cmd == "username":
                print(f"Your user name: ", userName)

            elif cmd == "games":
                res_getGames, ok = await getGames(websocket)
                if not ok:
                    continue
                
                games = res_getGames["games"]
                if len(games) == 0:
                    print("No games to join.")
                    continue

                for i, game in enumerate(games):
                    print("Game List: \n")
                    print(f"{i}. {game['ID']} \n")
            
            # also the game loop
            elif cmd == "join":
                if playerID == None:
                    print("Please log in first.")
                    continue

                gameID = forceGet(cmd_List, 1)
                if gameID == None:
                    print("No game id given.")
                    continue

                res_joinGame, ok = await joinGame(websocket, userName, playerID, gameID)
                if not ok:
                    continue
                
                print(f"Joined game {res_joinGame['ID']}")

                result, ok = await gameLoop(websocket, userName, playerID, gameID)
                if not ok:
                    return
                
            elif cmd == "create":
                if playerID == None:
                    print("Please log in first.")
                    continue

                res_createGame, ok = await createGame(websocket, userName, playerID)
                if not ok:
                    continue 

                gameID = res_createGame["ID"]
                print(f"Game {gameID} was created.")

            elif cmd == "start":
                if gameID == None:
                    print("Log in and join a game first. To see all games, use the 'games' command.")
                
                ticks = forceGet(cmd_List, 1)
                gameTimeout = forceGet(cmd_List, 2)
                gameRetentionTime = forceGet(cmd_List, 3)

                if not ticks:
                    print("Please give second argument for ticks")
                    continue

                if not gameTimeout:
                    print("Please give third argument for gameTimeout.")
                    continue

                res_startTournament, ok = await startGame(websocket, userName, ticks, gameTimeout, gameRetentionTime)
                if not ok:
                    continue

                print("Game was started.")

                while(True):
                    raw = await websocket.recv()
                    res = json.load(StringIO(raw))

                    print("Response: ", res)

            elif cmd == "quit":
                print("All done!")
                return
            
            elif cmd == "help":
                print("Commandlist: \n")
                print("login <userName> | admin - Logs into game server. Provide a username or 'admin' as second argument.")
                print("logout - Deletes current username and id.")
                print("playerid - Prints your player ID.")
                print("username - Prints your user name.")
                print("games - Prints games list.")
                print("join <gameID> - Joins a game with a given gameID.")
                print("create - Creates a game.")
                print("start <ticks> <timeOut> <gameRetentionTime?> - Requests the game to start with given ticks, timeOut and optional Retentiontime.")

            else:
                print("Unrecognized command.")
                continue
            
                

asyncio.get_event_loop().run_until_complete(parseGame())