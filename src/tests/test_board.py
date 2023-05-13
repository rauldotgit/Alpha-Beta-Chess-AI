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
    newBoard = board.Board()
    newBoard.fenGameSetup(maps.FEN_HARD)
    newBoard.printBoard()

    # maps.printMap(newBoard.board_union)
    # maps.printMap(newBoard.white_board_union)
    # maps.printMap(newBoard.black_board_union)

    newBoard.printMoveList()
    print(newBoard.castling & 1)

def test_save_current_state():
    newBoard = board.Board()
    newBoard.saveCurrentState()

    # print(newBoard.prevState)
