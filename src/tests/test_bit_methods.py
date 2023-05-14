import src.chess.bitmethods as bit
import src.chess.maps as maps

# def test_convert_to_int():
#     print(bitArrayToInt(maps.WHITE_PAWNS_ARRAY))
#     print(bitArrayToInt(maps.WHITE_ROOKS_ARRAY))
#     print(bitArrayToInt(maps.WHITE_KNIGHTS_ARRAY))
#     print(bitArrayToInt(maps.WHITE_BISHOPS_ARRAY))
#     print(bitArrayToInt(maps.WHITE_QUEEN_ARRAY))
#     print(bitArrayToInt(maps.WHITE_KING_ARRAY))
    
#     print(bitArrayToInt(maps.BLACK_PAWNS_ARRAY))
#     print(bitArrayToInt(maps.BLACK_ROOKS_ARRAY))
#     print(bitArrayToInt(maps.BLACK_KNIGHTS_ARRAY))
#     print(bitArrayToInt(maps.BLACK_BISHOPS_ARRAY))
#     print(bitArrayToInt(maps.BLACK_QUEEN_ARRAY))
#     print(bitArrayToInt(maps.BLACK_KING_ARRAY))

    # print(bitArrayToInt(maps.NOT_FILE_A))
    # print(bitArrayToInt(maps.NOT_FILE_AB))
    # print(bitArrayToInt(maps.NOT_FILE_GH))
    # print(bitArrayToInt(maps.NOT_FILE_H))

def test_bitarray_to_int():
    wpi = bit.bitArrayToInt(maps.WHITE_PAWNS_ARRAY)
    assert wpi == maps.WHITE_PAWNS_MAP
    wri = bit.bitArrayToInt(maps.WHITE_ROOKS_ARRAY)
    assert (wri == maps.WHITE_ROOKS_MAP)
    wki = bit.bitArrayToInt(maps.WHITE_KNIGHTS_ARRAY)
    assert (wki == maps.WHITE_KNIGHTS_MAP)
    wbi = bit.bitArrayToInt(maps.WHITE_BISHOPS_ARRAY)
    assert (wbi == maps.WHITE_BISHOPS_MAP)
    wqi = bit.bitArrayToInt(maps.WHITE_QUEEN_ARRAY)
    assert (wqi == maps.WHITE_QUEEN_MAP)
    wkgi = bit.bitArrayToInt(maps.WHITE_KING_ARRAY)
    assert (wkgi == maps.WHITE_KING_MAP)

    bpi = bit.bitArrayToInt(maps.BLACK_PAWNS_ARRAY)
    assert (bpi == maps.BLACK_PAWNS_MAP)
    bri = bit.bitArrayToInt(maps.BLACK_ROOKS_ARRAY)
    assert (bri == maps.BLACK_ROOKS_MAP)
    bki = bit.bitArrayToInt(maps.BLACK_KNIGHTS_ARRAY)
    assert (bki == maps.BLACK_KNIGHTS_MAP)
    bbi = bit.bitArrayToInt(maps.BLACK_BISHOPS_ARRAY)
    assert (bbi == maps.BLACK_BISHOPS_MAP)
    bqi = bit.bitArrayToInt(maps.BLACK_QUEEN_ARRAY)
    assert (bqi == maps.BLACK_QUEEN_MAP)
    bkgi = bit.bitArrayToInt(maps.BLACK_KING_ARRAY)
    assert (bkgi == maps.BLACK_KING_MAP)

def test_int_to_bitarray():
    pass

def test_full_union():

    test_array = [
        0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    1, 1, 1, 1, 1, 1, 1, 1,
	    1, 1, 1, 1, 1, 1, 1, 1,
    ]

    test_map = bit.bitArrayToInt(test_array)
    result_map = bit.fullUnion(maps.WHITE_MAPS)
    assert test_map == result_map

def test_get_lsb_index():

    test_array = [
        0, 0, 0, 1, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array)
    test_index = 3
    result_index = bit.getLsbIndex(test_map)
    assert test_index == result_index

    test_array = [
        0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array)
    test_index = -1
    result_index = bit.getLsbIndex(test_map)
    assert test_index == result_index

def test_pop_bit():

    test_array = [ 
        0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 1, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array)
    test_index = 19

    assumed_array = [
        0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
    ]

    result_map = bit.popBit(test_map, test_index)
    assumed_map = bit.bitArrayToInt(assumed_array)
    assert result_map == assumed_map

    test_array = [ 
        0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 1, 0, 0, 1, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 1, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array)
    test_index = 22

    assumed_array = [
        0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 1, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 1, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
    ]
    
    assumed_map = bit.bitArrayToInt(assumed_array)
    result_map = bit.popBit(test_map, test_index)
    assert assumed_map == result_map

def test_get_bit():

    test_array = [ 
        0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 1, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array)
    test_index = 19

    result_bool = bit.getBit(test_map, test_index)
    assert result_bool == test_map

    test_array = [ 
        0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 1,
    ]

    test_map = bit.bitArrayToInt(test_array)
    test_index = 0

    assumed_bool = False
    result_bool = bit.getBit(test_map, test_index)
    assert result_bool == assumed_bool

def test_get_bit_indices():

    test_array = [ 
        0, 1, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 1, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 0, 0, 0, 0, 0, 0, 0,
	    0, 1, 0, 0, 0, 0, 0, 1,
    ]
    test_map = bit.bitArrayToInt(test_array)
    assumed_array = [1, 27, 57, 63]
    result_array = bit.getBitIndices(test_map)

    assert assumed_array == result_array

