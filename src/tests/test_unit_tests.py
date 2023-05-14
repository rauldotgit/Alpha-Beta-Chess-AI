import src.chess.board as board
import src.chess.maps as maps

def test_demon():
    test_fen = "1R6/3R4/P2Pk3/4P3/4KP2/8/8/8 b - - 0 0"
    test_count = 1

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    moves = newBoard.returnLegalMoves()

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_0():
    test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
    test_count = 20
    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    moves = newBoard.returnLegalMoves()

    moveCount = len(moves)
    assert moveCount == test_count
    
def test_group_A_1():
    test_fen = "2b1k3/p5rp/Pppb1p1P/n2qpPpR/1PPpP1P1/R2P1Q1B/1Br4n/1N2K1N1 w - - - -"
    test_count = 33

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    moves = newBoard.returnLegalMoves()

    moveCount = len(moves)
    assert moveCount == test_count
    
def test_group_A_2():
    test_fen = "r1bqk2r/ppp3pp/5p2/2nPp3/P1Pn2P1/3P1N2/1P2BP1P/RN1Q1RK1 b - - - -"
    test_count = 42

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    moves = newBoard.returnLegalMoves()

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_AB_1():
    test_fen = "rnbqk3/p6P/2n1p1P1/1r3p2/8/1PN1K3/P4P2/R1BQ1BNR w q - 0 1"
    test_count = 50

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    moves = newBoard.returnLegalMoves()

    moveCount = len(moves)
    assert moveCount == test_count

def test_group_AB_2():
    test_fen = "rnb1kbnr/p6p/Bp4p1/8/Q4p2/N2qBN2/PP3PPP/R3K2R b kq - 0 1"
    test_count = 9

    newBoard = board.Board()
    newBoard.fenGameSetup(test_fen)
    moves = newBoard.returnLegalMoves()

    moveCount = len(moves)
    assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppp1ppp/8/4p3/3PP3/8/PPP2PPP/RNBQKBNR b KQkq d3 0 2"
#     test_count = 28

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

# def test_group_0():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     test_count = 20

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     # number of possible moves
#     moveCount = newBoard.moveIndex + 1
#     assert moveCount == test_count

