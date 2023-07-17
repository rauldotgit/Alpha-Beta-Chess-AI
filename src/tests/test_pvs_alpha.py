import src.chess.board as board
import src.chess.maps as maps
import time

# def test_PVS_1():
#     newBoard = board.Board()
#     newBoard.fenGameSetup(maps.FEN_START)
#     newBoard.printBoard()

#     start_time = time.time()
#     newBoard.negamax(-50000, 50000, 5)
#     best_move_1 = newBoard.getParsedMove(newBoard.bestMove)
#     print("\n ALPHA BETA")
#     print("Best move: ", best_move_1)
#     print("Nodes searched: ", newBoard.nodeCount)
#     print("Time: ", (time.time()-start_time))

#     newBoard.nodeCount = 0
#     start_time = time.time()

#     newBoard.principalVariationSearch(-50000, 50000, 5)
#     best_move_1_pvs = newBoard.getParsedMove(newBoard.getBestMove())
#     print("\n PRINCIPAL VARIATION SEARCH")
#     print("Best move: ", best_move_1_pvs)
#     print("Nodes searched: ", newBoard.nodeCount)
#     print("Time: ", (time.time()-start_time))

# def test_PVS_2():
#     newBoard2 = board.Board()
#     newBoard2.fenGameSetup(maps.FEN_HARD)
#     newBoard2.printBoard()

#     newBoard2.resetBoards()

#     start_time = time.time()
#     newBoard2.negamax(-50000, 50000, 5)
#     best_move_2 = newBoard2.getParsedMove(newBoard2.bestMove)
#     print("\n ALPHA BETA")
#     print("Best move: ", best_move_2)
#     print("Nodes searched: ", newBoard2.nodeCount)
#     print("Time: ", (time.time()-start_time))

#     newBoard2.nodeCount = 0
#     start_time = time.time()

#     newBoard2.principalVariationSearch(-50000, 50000, 5)
#     best_move_2_pvs = newBoard2.getParsedMove(newBoard2.getBestMove())
#     print("\n PRINCIPAL VARIATION SEARCH")
#     print("Best move: ", best_move_2_pvs)
#     print("Nodes searched: ", newBoard2.nodeCount)
#     print("Time: ", (time.time()-start_time))

# def test_PVS_3():
#     newBoard3 = board.Board()
#     newBoard3.fenGameSetup(maps.FEN_VERY_HARD)
#     newBoard3.printBoard()

#     newBoard3.resetBoards()

#     start_time = time.time()
#     newBoard3.negamax(-50000, 50000, 5)
#     best_move_3 = newBoard3.getParsedMove(newBoard3.bestMove)
#     print("\n ALPHA BETA")
#     print("Best move: ", best_move_3)
#     print("Nodes searched: ", newBoard3.nodeCount)
#     print("Time: ", (time.time()-start_time))

#     newBoard3.nodeCount = 0
#     start_time = time.time()

#     newBoard3.principalVariationSearch(-50000, 50000, 5)
#     best_move_3_pvs = newBoard3.getParsedMove(newBoard3.getBestMove())
#     print("\n PRINCIPAL VARIATION SEARCH")
#     print("Best move: ", best_move_3_pvs)
#     print("Nodes searched: ", newBoard3.nodeCount)
#     print("Time: ", (time.time()-start_time))

