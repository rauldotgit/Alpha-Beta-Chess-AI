import src.chess.board as board
import time

def test_group_N_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r3kb1r/1p1nqp1p/p2p1np1/P1p1p3/2P1P3/2N1K1PP/1P1P1P2/R1BQ1B1R w kq - 1 11"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_N_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r1bqkbnr/p2ppppp/2p5/1p4N1/2B1P3/8/PPQP1PPP/RNB1K2R w KQkq b6 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_A_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r2qk2r/p1ppn1pp/bpnb1p2/4p3/4P3/2NPBN2/PPP1BPPP/R2Q1RK1 w Qkq - - -"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_A_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "8/1k6/1r3rp1/8/4R2P/2K5/3R4/8 w - - - -"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_B_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r1bq1rk1/pp1nbppp/2pp1n2/4p3/P1BPP3/2N2N2/1PP2PPP/R1BQ1RK1 w - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_B_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "4K3/4P1k1/8/8/8/8/7R/5r2 w - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_J_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "2k5/6q1/3P1P2/4N3/8/1K6/8/8 w - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_J_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "k7/8/3p4/4q3/3P4/8/4Q3/K7 w - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_C_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "rnbqkbnr/1pppppp1/p6p/8/2B1P3/5N2/PPPP1PPP/RNBQK2R b KQkq - 1 3"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_C_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r1b2rk1/ppqn1ppp/2n1p3/3pP3/1b1P4/3B1N2/PP1N1PPP/R1BQR1K1 b - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_C_3():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "8/2k5/R7/2PK1p1p/1p4r1/1P6/P5P1/8 w - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_O_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r2q1rk1/pp2ppbp/2np1np1/8/2PP4/2N1PN2/PPQ2PPP/R1B1K2R b KQ - 4 8"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_O_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r4rk1/1bp1qp1p/p2p1np1/2nPp3/2P1P3/1PN2N2/PB1Q1PPP/R3K2R w KQ - 2 14"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_Q_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "3r3k/pQ2R2p/6p1/3Pbp2/8/1Pq3P1/P4P1P/6K1 w - - 0 31"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_Q_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "3r1k2/2R1p2p/1p2Qpp1/p6q/1P2nP2/4PR2/P5PP/6K1 b - - 0 34"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_K_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "4k3/p7/8/8/1P2N1p1/8/6r1/3K4 w - - - -"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_K_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "4k3/p7/7n/8/K5P1/2r5/P5P1/8 w - - - -"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_S_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "rnb1kbnr/pppp1ppp/4pq2/6N1/8/2N5/PPPPPPPP/R1BQKB1R b KQkq 0 5"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_S_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r1b1kbnr/p2p1ppp/1p3q2/1BpNp3/4P3/3Q1N2/PPP2PPP/R1B1K2R w KQkq 0 7"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_L_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r3k1r1/2pp1p2/bpn1pqpn/p1b4p/6P1/BP1P1P1N/P1PQP2P/RN2KB1R b KQ - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_L_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "7k/6pp/1P2B3/3b1n2/6P1/3K1P2/3P2N1/4Q3 b - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_AD_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r2q1rk1/ppp2ppp/2n5/2b1PbN1/8/4p3/PPP3PP/RNBQR1K1 w - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_AD_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r3r1k1/p4ppp/1p1p4/2pP4/Q5bq/P1B1P3/1P3PPP/3R1RK1 b - - 1 21"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_AB_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "rnbqk3/p6P/2n1p1P1/1r3p2/8/1PN1K3/P4P2/R1BQ1BNR w q - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_AB_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "rnb1kbnr/p6p/Bp4p1/8/Q4p2/N2qBN2/PP3PPP/R3K2R b kq - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_H_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "rn1qr1k1/1pp2ppp/p2bbn2/3p4/3P1B2/2NB1N2/PPPQ1PPP/2KR3R w - - 0 10"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_H_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "rq2kb1r/pbppp1p1/n4p1p/1p1n4/7P/1PP1PNPR/P1QP1P2/RNB1KB2 b Qkq - 2 9"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_M_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "8/5P2/8/p4Kpp/6pk/P5p1/6P1/8 w - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_M_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r1bq1rk1/ppp2ppp/2n1pn2/2b5/2P5/2N1PN2/PPQ2PPP/R1B1KB1R w KQ - 0 11"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_G_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "4r1k1/pp4pp/8/q1p1N3/5P2/1P4P1/P6P/3Q2K1 w - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_G_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "4r3/5pk1/7p/8/1p4P1/1P1Rq1P1/1N4BP/1NrR3K b - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_T_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "2kr3r/pp2q3/2p2p2/3p4/3Pb3/5nPp/PPB2P1B/R2QR1K1 w - - 1 24"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_T_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "1R6/6n1/4p3/3p3P/6P1/3nk3/1p6/6K1 w - - 1 48"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_R_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "rnbqk1nr/pp1p1ppp/2p5/2b1p1B1/8/3P1N2/PPP1PPPP/RN1QKB1R w KQkq - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_R_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r3k3/p4ppp/n1p2q1n/2b1p1B1/4P3/N7/P1PQ2PP/K1R2B1R w Kq - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_P_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r1b1k1nr/1pp2ppp/p1p5/2b1p3/P3P3/2N2PP1/1PPP3q/R1B1KQ2 w KQkq - - -"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_P_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "8/2p2R2/1p2p1Np/1P5k/3nr3/8/P7/2K5 w - - 0 34"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_X_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r2qkb1r/p1p2ppp/5n2/1p1P4/3Q4/2N2P2/PPP2P1P/R3KB1R w - - - -"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_X_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r2qkb1r/ppp2ppp/2np1n2/8/3pP3/2N1BP2/PPP2P1P/R2QKB1R w - - - -"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_I_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    # makes no sense
    pass


def test_group_I_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "6k1/p2qpp2/2p2PpQ/1p4N1/2n5/2N5/PPP2P2/2K5 b - - - -"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_V_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r3r1k1/p4ppp/2Q1b3/4N3/5q2/4RP2/PPB3PP/R5K1 w - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_V_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r3k2r/p2n1ppp/2p5/1pN1p1B1/8/3PnP2/PP4PP/R3K2R b KQkq - 0 16"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_F_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "rnbqk2r/ppppppbp/5np1/8/2PP4/2N2N2/PP2PPPP/R1BQKB1R b KQkq - 2 4"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_F_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "3r2k1/p6p/6p1/4b3/2P5/8/P1K3PP/5R2 w - - 5 27"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_AF_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "r1bqk1nr/8/2n3P1/p1bP3p/3pPPQ1/p1N5/8/R1B1KBNR b KQkq - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_AF_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "rnbqkbnr/p1pppppp/8/1p6/Q7/2P5/PP1PPPPP/RNB1KBNR w KQkq - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_AA_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "5rk1/1p4pp/2R1p3/p5Q1/P4P2/6qr/2n3PP/5RK1 w - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_AA_2():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    test_fen = "5r1k/2p5/4R3/2N3np/1b4p1/6P1/2Q4P/2K5 b - - 0 1"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")



def test_group_Z_1():
    print("-----------------------------------------------------------------------")
    test_depth = 3
    # no king
    pass
    test_fen = "8/8/8/8/8/b3P3/8/2B5 w - - - -"

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    newBoard.printBoard()

    sTime_1 = time.time()
    newBoard.minimax(test_depth)
    eTime_1 = time.time() - sTime_1

    print("\n")
    print(f"Minimax depth {test_depth} time: {round(eTime_1,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    sTime_2 = time.time()
    newBoard.negamax(-50000, 50000, test_depth)
    eTime_2 = time.time() - sTime_2

    print(f"Alpha-beta depth {test_depth} time: {round(eTime_2,2)}s")
    print(f"Nodes traversed: {newBoard.nodeCount}.")
    print("Best Move:\n")
    newBoard.printMove(newBoard.bestMove)
    print("\n")
