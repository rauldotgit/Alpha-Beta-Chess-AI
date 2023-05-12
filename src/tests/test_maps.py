import src.chess.maps as maps
import src.chess.board as board

def test_fen_to_arrays():
    bitArrays = maps.fenBoardToBitArrays(maps.STRING_BOARD)
    
    assert (maps.WHITE_PAWNS_ARRAY == bitArrays[0]).all()
    assert (maps.WHITE_ROOKS_ARRAY == bitArrays[1]).all()
    assert (maps.WHITE_KNIGHTS_ARRAY == bitArrays[2]).all()
    assert (maps.WHITE_BISHOPS_ARRAY == bitArrays[3]).all()
    assert (maps.WHITE_QUEEN_ARRAY == bitArrays[4]).all()
    assert (maps.WHITE_KING_ARRAY == bitArrays[5]).all()

    assert (maps.BLACK_PAWNS_ARRAY == bitArrays[6]).all()
    assert (maps.BLACK_ROOKS_ARRAY == bitArrays[7]).all()
    assert (maps.BLACK_KNIGHTS_ARRAY == bitArrays[8]).all()
    assert (maps.BLACK_BISHOPS_ARRAY == bitArrays[9]).all()
    assert (maps.BLACK_QUEEN_ARRAY == bitArrays[10]).all()
    assert (maps.BLACK_KING_ARRAY == bitArrays[11]).all()

def test_fen_to_bitmaps():
    bitMaps = maps.fenBoardToBitMaps(maps.STRING_BOARD)
    
    assert maps.WHITE_PAWNS_MAP == bitMaps[0]
    assert maps.WHITE_ROOKS_MAP == bitMaps[1]
    assert maps.WHITE_KNIGHTS_MAP == bitMaps[2]
    assert maps.WHITE_BISHOPS_MAP == bitMaps[3]
    assert maps.WHITE_QUEEN_MAP == bitMaps[4]
    assert maps.WHITE_KING_MAP == bitMaps[5]

    assert maps.BLACK_PAWNS_MAP == bitMaps[6]
    assert maps.BLACK_ROOKS_MAP == bitMaps[7]
    assert maps.BLACK_KNIGHTS_MAP == bitMaps[8]
    assert maps.BLACK_BISHOPS_MAP == bitMaps[9]
    assert maps.BLACK_QUEEN_MAP == bitMaps[10]
    assert maps.BLACK_KING_MAP == bitMaps[11]

# def test_pp_bit_arrays():
#     maps.ppBitArrays(maps.ALL_ARRAYS)

# def test_pp_bit_maps():
#     maps.ppBitMaps(maps.ALL_MAPS)

def test_fen_to_board_info():
    pieceMaps, turn, castle, enpassant, halfMoves, fullMoves = maps.fenToBoardInfo(maps.FEN_START)
    # maps.ppBitMaps(pieceMaps)

    assert turn == 0
    assert castle == 15
    assert enpassant == 64
    assert halfMoves == 0
    assert fullMoves == 1

    pieceMaps, turn, castle, enpassant, halfMoves, fullMoves = maps.fenToBoardInfo(maps.FEN_SOME_MOVE)
    # maps.ppBitMaps(pieceMaps)

    assert turn == 0
    assert castle == 15
    assert enpassant == maps.FIELD_OBJ['c6']
    assert halfMoves == 0
    assert fullMoves == 2
