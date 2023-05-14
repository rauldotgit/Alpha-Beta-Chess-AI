import src.chess.board as board
import src.chess.maps as maps
import time

FEN_EMPTY = '8/8/8/8/8/8/8/8 w - - '
FEN_START = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
FEN_SOME_MOVE = 'rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2'
FEN_HARD = 'r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R b KQkq - 0 1'
FEN_VERY_HARD = 'rnbqkb1r/pp1p1pPp/8/2p1pP2/1P1P4/3P3P/P1P1P3/RNBQKBNR w KQkq e6 0 1'
FEN_CMK = 'r2q1rk1/ppp2ppp/2n1bn2/2b1p3/3pP3/3P1NPP/PPP1NPB1/R1BQ1RK1 b - - 0 9'
FEN_LATE = '1R6/3R4/P2Pk3/4P3/4KP2/8/8/8 b - - 0 0'

# def test_benchmark_movegen_start():
#     startTime = time.time()

#     newBoard = board.Board()
#     newBoard.fenGameSetup(FEN_START)

#     newBoard.printBoard()

#     runs = 1000

#     for i in range(runs + 1):
#         newBoard.generateMoves()

#     duration = time.time() - startTime

#     print(newBoard.printMoveList())
#     print(f'Bechmark start duration {runs} runs: {duration}')
    

# def test_benchmark_movegen_mid():
#     startTime = time.time()

#     newBoard = board.Board()
#     newBoard.fenGameSetup(FEN_HARD)

#     newBoard.printBoard()

#     runs = 1000

#     for i in range(runs + 1):
#         newBoard.generateMoves()

#     duration = time.time() - startTime

#     print(newBoard.printMoveList())
#     print(f'Bechmark mid duration {runs} runs: {duration}')

# def test_benchmark_movegen_late():
#     startTime = time.time()

#     newBoard = board.Board()
#     newBoard.fenGameSetup(FEN_LATE)

#     newBoard.printBoard()

#     runs = 1000

#     for i in range(runs + 1):
#         newBoard.generateMoves()

#     duration = time.time() - startTime

#     print(newBoard.printMoveList())
#     print(f'Bechmark end duration {runs} runs: {duration}')
