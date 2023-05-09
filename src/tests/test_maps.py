import src.chess.maps as maps

# def test_pp():
#     maps.ppPieceArray(maps.WHITE_BISHOPS_ARRAY, "B")
#     maps.ppSideArrays(maps.WHITE_ARRAYS, 0)
#     maps.ppAllArrays(maps.ALL_ARRAYS)

def test_role_array_to_bit_arrays():

    test_array_1 = [
        "r", "n", "b", "q", "k", "b", "n", "r",
        "p", "p", "p", "p", "p", "p", "p", "p",
        "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "",
        "", "", "", "", "", "", "", "",
        "P", "P", "P", "P", "P", "P", "P", "P",
        "R", "N", "B", "Q", "K", "B", "N", "R",
    ]

    result_arrays = maps.roleArrayToBitArrays(test_array_1)

    assert (result_arrays[0] == maps.WHITE_PAWNS_ARRAY).all()
    assert (result_arrays[1] == maps.WHITE_ROOKS_ARRAY).all()
    assert (result_arrays[2] == maps.WHITE_KNIGHTS_ARRAY).all()
    assert (result_arrays[3] == maps.WHITE_BISHOPS_ARRAY).all()
    assert (result_arrays[4] == maps.WHITE_QUEEN_ARRAY).all()
    assert (result_arrays[5] == maps.WHITE_KING_ARRAY).all()
    assert (result_arrays[6] == maps.BLACK_PAWNS_ARRAY).all()
    assert (result_arrays[7] == maps.BLACK_ROOKS_ARRAY).all()
    assert (result_arrays[8] == maps.BLACK_KNIGHTS_ARRAY).all()
    assert (result_arrays[9] == maps.BLACK_BISHOPS_ARRAY).all()
    assert (result_arrays[10] == maps.BLACK_QUEEN_ARRAY).all()
    assert (result_arrays[11] == maps.BLACK_KING_ARRAY).all()