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
    assert (newBoard.white_pawns == maps.WHITE_PAWNS_MAP)
    assert (newBoard.black_pawns == maps.BLACK_PAWNS_MAP)

    assert (newBoard.white_rooks == maps.WHITE_ROOKS_MAP)
    assert (newBoard.black_rooks == maps.BLACK_ROOKS_MAP)

    assert (newBoard.white_knights == maps.WHITE_KNIGHTS_MAP)
    assert (newBoard.black_knights == maps.BLACK_KNIGHTS_MAP)

    assert (newBoard.white_bishops == maps.WHITE_BISHOPS_MAP)
    assert (newBoard.black_bishops == maps.BLACK_BISHOPS_MAP)

    assert (newBoard.white_queen == maps.WHITE_QUEEN_MAP)
    assert (newBoard.black_queen == maps.BLACK_QUEEN_MAP)

    assert (newBoard.white_king == maps.WHITE_KING_MAP)
    assert (newBoard.black_king == maps.BLACK_KING_MAP)

# def test_full_union_map() -> None:
#     newBoard = board.Board()
#     startUnion = newBoard.fullUnion()
#     assert (startUnion == maps.SET_BOARD_UNION).all()