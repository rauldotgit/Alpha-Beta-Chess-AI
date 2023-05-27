import src.chess.board as board
import src.chess.maps as maps
import numpy as np

import random

def test_demon():
    test_fen = "1R6/3R4/P2Pk3/4P3/4KP2/8/8/8 b - - 0 0"
    test_count = 1

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_0():
    test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
    test_count = 20
    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count
    
def test_group_A_1():
    test_fen = "2b1k3/p5rp/Pppb1p1P/n2qpPpR/1PPpP1P1/R2P1Q1B/1Br4n/1N2K1N1 w - - - -"
    test_count = 33

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count
    
def test_group_A_2():
    test_fen = "r1bqk2r/ppp3pp/5p2/2nPp3/P1Pn2P1/3P1N2/1P2BP1P/RN1Q1RK1 b k - - -"
    test_count = 42

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_AB_1():
    test_fen = "rnbqk3/p6P/2n1p1P1/1r3p2/8/1PN1K3/P4P2/R1BQ1BNR w q - 0 1"
    test_count = 50

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_AB_2():
    test_fen = "rnb1kbnr/p6p/Bp4p1/8/Q4p2/N2qBN2/PP3PPP/R3K2R b kq - 0 1"
    test_count = 9

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_AF_1():
    test_fen = "8/8/4kpp1/3p4/p6P/2B4b/6P1/6K1 w - - 1 48"
    test_count = 17

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_AF_2():
    test_fen = "5rk1/pp4pp/4p3/2R3Q1/3n4/6qr/P1P2PPP/5RK1 w - - 2 24"
    test_count = 41

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_AH_1():
    test_fen = "1n1qkbnr/2pppppp/p7/p2P4/6Q1/8/PPPP1PPP/R1B1K1NR b KQk - 0 6"
    test_count = 16

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_AH_2():
    test_fen = "8/8/r3k3/8/8/3K4/8/8 b - - 0 31"
    test_count = 18

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_C_1():
    test_fen = "r1b1kb1r/pp1p1ppp/1q3n2/2p5/4P3/2N5/PPP2PPP/R1BQKB1R w - - 0 1"
    test_count = 40

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_C_2():
    test_fen = "rn1qkbnr/ppp1ppp1/4b3/3pN2p/8/2N4P/PPPPPPP1/R1BQKB1R w - - 0 1"
    test_count = 29

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_F_1():
    test_fen = "rnbqk2r/ppppppbp/5np1/8/2PP4/2N2N2/PP2PPPP/R1BQKB1R b KQkq - 4 26"
    test_count = 26

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_F_2():
    test_fen = "3r2k1/p6p/6p1/4b3/2P5/8/P1K3PP/5R2 w - - 5 24"
    test_count = 24

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_G_1():
    test_fen = "r1bqkr2/pp1pbpQp/8/2p1P3/2B5/2N5/PPP2PPP/R1B1K2R b KQq - 2 10"
    test_count = 20

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_G_2():
    test_fen = "r2r2k1/ppp1p2p/6p1/4b1p1/PnP4P/2N4P/1P6/R3KB2 w Q - 0 17"
    test_count = 22

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_J_1():
    test_fen = "r3k2r/pp6/2p3Pb/2N1pP2/Q2p4/4P3/PP1K4/7R w q e6 0 34"
    test_count = 43

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_J_2():
    test_fen = "r3k2r/pp2qppp/1np2n2/2bPp1B1/B2P2Q1/2N2N2/PPP2PPP/2KR3R b kq - 0 10"
    test_count = 36

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_K_1():
    test_fen = "4k3/pp3pp1/8/8/1P2N1p1/7r/3K4/2r5 b - - - -"
    test_count = 41

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_K_2():
    test_fen = "r3k2r/p5pp/2p3qn/7K/6P1/2N4N/P5PP/7R w - - - -"
    test_count = 1

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_N_1():
    test_fen = "r2qk2r/pp1bp1bp/2np1np1/2pP4/2P1P3/2N2N2/PP3PPP/R1BQKB1R w - - 0 1"
    test_count = 38

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_N_2():
    test_fen = "6r1/p5k1/3Q4/2N5/5P2/1p6/P5KP/4qR2 w - - 0 25"
    test_count = 42

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_O_1():
    test_fen = "1k6/p1nrp3/n2p4/2p5/3PP3/2P2P2/P7/RN4K1 w - - - -"
    test_count = 14

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_O_2():
    test_fen = "8/3np3/3pk3/2p5/1PKPP3/2P2P2/8/8 w - - - -"
    test_count = 9

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_P_1():
    test_fen = "r1b1k1nr/1pp2ppp/p1p5/2b1p3/P3P3/2N2PP1/1PPP3q/R1B1KQ2 w Qkq - 0 11"
    test_count = 27

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_P_2():
    test_fen = "8/2p2R2/1p2p1Np/1P5k/3nr3/8/P7/2K5 w - - 0 34"
    test_count = 24

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_R_1():
    test_fen = "r1bqkb1r/p2p2pp/1pn2p1n/2p1p3/3P1B2/1P3N2/P1P1PPPP/RN1QKB1R w KQkq - 0 1"
    test_count = 34

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_R_2():
    test_fen = "2r4r/8/8/4k3/8/R7/8/4K2R w K - 0 1"
    test_count = 29

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_S_1():
    test_fen = "rnbqkbnr/pppp1ppp/8/4p3/3PP3/8/PPP2PPP/RNBQKBNR b KQkq d3 0 2"
    test_count = 30

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_S_2():
    test_fen = "r3k1nr/pppb1ppp/4q3/2b1B3/3Q1P2/2N5/PPP1P1PP/R3KB1R w KQkq - 1 10"
    test_count = 43

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_T_1():
    test_fen = "r1bqk1nr/ppp2ppp/2n1p3/3p4/1b1P1B2/4PN2/PPP2PPP/RN1QKB1R w KQkq - 3 5"
    test_count = 6

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_T_2():
    test_fen = "8/8/4k3/3pP3/3K4/8/8/8 b - - 12 45"
    test_count = 4

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_U_1():
    test_fen = "r1bq1rk1/ppp2ppp/2np1n2/3p4/2PP4/2NBPN2/PP3PPP/R1BQK2R w Kk - 4 6"
    test_count = 43

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_U_2():
    test_fen = "r4rk1/1pp1q1pp/2np1pn1/p3p3/2PPP3/2N1BP2/PPQ2P1P/R3K2R w KQ - 2 14"
    test_count = 40

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_U_3():
    test_fen = "2kr3r/1p3pp1/p1nqbn1p/3p4/3P2P1/1BN2N2/PPP1QPBP/R4RK1 w Kq - 0 14"
    test_count = 41

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_U_4():
    test_fen = "r4rk1/1bqn1ppp/p2bpn2/1p1p4/2pP4/1PNBPN2/PB3PPP/R2Q1RK1 w KK - 1 12"
    test_count = 40

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_V_1():
    test_fen = "r1bq1rk1/ppp2ppp/2nb1n2/3pp3/2PPP3/2N2N2/PP2BPPP/R1BQ1RK1 w - - 0 10"
    test_count = 36

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_V_2():
    test_fen = "2kr1b1r/pp2pppp/2p5/1B6/2PPn3/8/PP3PPP/R1B1R1K1 b - - 0 14"
    test_count = 30

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_X_1():
    test_fen = "8/6P1/5K1k/6N1/5N2/8/8/8 w - - 0 14"
    test_count = 23

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_X_2():
    test_fen = "rnbqk1nr/pppp1ppp/4p3/8/1bPP4/8/PP2PPPP/RNBQKBNR w - - 0 0"
    test_count = 4

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)

    newMoveList = board.MoveList()
    newBoard.generateMoves(newMoveList)
    moves = newBoard.getLegalMoves(newMoveList)

    moveCount = len(moves)
    assert moveCount == test_count

