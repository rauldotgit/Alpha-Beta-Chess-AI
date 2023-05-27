import src.chess.board as board
import src.chess.maps as maps

def test_next_turn() -> None:
    newBoard = board.Board()
    assert newBoard.turn == 0

    newBoard.nextTurn()
    assert newBoard.turn == 1

    newBoard.nextTurn()
    assert newBoard.turn == 0

def test_set_pieces() -> None:
    newBoard = board.Board()
    assert (newBoard.pieceMaps[0] == maps.WHITE_PAWNS_MAP)
    assert (newBoard.pieceMaps[1] == maps.WHITE_ROOKS_MAP)
    assert (newBoard.pieceMaps[2] == maps.WHITE_KNIGHTS_MAP)
    assert (newBoard.pieceMaps[3] == maps.WHITE_BISHOPS_MAP)
    assert (newBoard.pieceMaps[4] == maps.WHITE_QUEEN_MAP)
    assert (newBoard.pieceMaps[5] == maps.WHITE_KING_MAP)

    assert (newBoard.pieceMaps[6] == maps.BLACK_PAWNS_MAP)
    assert (newBoard.pieceMaps[7] == maps.BLACK_ROOKS_MAP)
    assert (newBoard.pieceMaps[8] == maps.BLACK_KNIGHTS_MAP)
    assert (newBoard.pieceMaps[9] == maps.BLACK_BISHOPS_MAP)
    assert (newBoard.pieceMaps[10] == maps.BLACK_QUEEN_MAP)
    assert (newBoard.pieceMaps[11] == maps.BLACK_KING_MAP)

# def test_full_union_map() -> None:
#     newBoard = board.Board()
#     startUnion = newBoard.fullUnion()
#     assert (startUnion == maps.SET_BOARD_UNION).all()

def test_get_piece_map():
    newBoard = board.Board()
    whitePawnMap = newBoard.pieceMaps[0]
    assert whitePawnMap == maps.WHITE_PAWNS_MAP

def test_move_gen():
    # newBoard = board.Board()
    # newBoard.fenGameSetup(maps.FEN_HARD)
    # newBoard.printBoard()

    # maps.printMap(newBoard.board_union)
    # maps.printMap(newBoard.white_board_union)
    # maps.printMap(newBoard.black_board_union)

    # newBoard.printMoveList()
    # print(newBoard.castling & 1)
    pass

def test_get_save_state():
    pass

def test_fen_to_board_info():
    
    pieceMaps, turn, castle, enpassant, halfMoves, fullMoves = board.fenToBoardInfo(maps.FEN_START)

    assert turn == 0
    assert castle == 15
    assert enpassant == 64
    assert halfMoves == 0
    assert fullMoves == 1

    pieceMaps, turn, castle, enpassant, halfMoves, fullMoves = board.fenToBoardInfo(maps.FEN_SOME_MOVE)

    assert turn == 0
    assert castle == 15
    assert enpassant == board.FIELD_OBJ['c6']
    assert halfMoves == 0
    assert fullMoves == 2

# def test_fen_game_setup():
#     newBoard2 = board.Board()

#     newBoard2.fenGameSetup(maps.FEN_HARD)

    # for piece in newBoard2.pieceMaps:
    #     maps.printMap(piece)
    # print('union')
    # maps.printMap(newBoard2.board_union)
    # print('white union')
    # maps.printMap(newBoard2.white_board_union)
    # print('black union')
    # maps.printMap(newBoard2.black_board_union)
    # maps.printMap(newBoard2.knightAttacks[maps.FIELD_OBJ['b1']])
    # newBoard2.printBoard()
    # newBoard2.printMoveList()

# def test_make_move():
#     pass

# def test_parse_move():
#     #TODO: THIS
#     pass

# def test_parse_position():
#     #TODO: THIS
#     pass

# def test_parse_command():
#     # TODO: THIS
#     pass

# def test_make_move_random():
#     # TODO: THIS
#     pass

# def test_generate_moves():
#     pass

# def test_uci_loop():
#     newBoard = board.Board()
#     newBoard.uciLoop()

def test_evaluate_score():
    newBoard = board.Board()
    newBoard.fenGameSetup(maps.FEN_START)

    score = newBoard.evaluateScore()
    assumed_score = 0
    assert score == assumed_score

def test_evaluate_score_2():
    fenString = 'rnbqkbnr/pppppppp/8/8/8/8/8/RNBQKBNR b KQkq - 0 1'

    newBoard = board.Board()
    newBoard.fenGameSetup(fenString)

    score = newBoard.evaluateScore()
    assumed_score = 810
    assert score == assumed_score

def test_score_move():
    pass

def test_search_move():
    newBoard = board.Board()
    newBoard.fenGameSetup(maps.FEN_HARD)

    newBoard.printBoard()

    newBoard.searchPosition(5, 30)
    # print(newBoard.nodeCount)

# def test_sort_move_list():
#     newBoard = board.Board()
#     newBoard.fenGameSetup(maps.FEN_HARD)

#     newBoard.printBoard()

#     print("Unsorted\n")
#     newBoard.printMoveList_withScores()
#     print("\n")

#     print("Sorted\n")
#     newBoard.sortMoveList()
#     newBoard.printMoveList_withScores()

#     newBoard = board.Board()
#     newBoard.fenGameSetup(maps.FEN_START)

#     for i in range(1, 5):
#         newBoard.minimax(i)
#         print(f'Depth {i}, best found move:')
#         newBoard.printMove(newBoard.bestMove)
#         print(f'Nodes searched: {newBoard.nodeCount}')
