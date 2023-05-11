import src.chess.movegen as gen
import src.chess.bitmethods as bit
import src.chess.maps as maps
import numpy as np

# ATTACK MASK TEST TEMPLATE 
# def test_some_mask():
    
#     test_field = FIELD_OBJ['']

#     block_array_1 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_array_1 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_1)
#     result_map = gen.someMask(test_field, bit.bitArrayToInt(block_array_1))
#     assert test_map == result_map

FIELD_OBJ = maps.FIELD_OBJ

def test_set_piece():
    test_map = 0

    test_field = FIELD_OBJ['d1']
    white_queen_map = gen.setPiece(test_field, test_map)
    assert maps.WHITE_QUEEN_MAP == white_queen_map

    test_field = FIELD_OBJ['d8']
    black_queen_map = gen.setPiece(test_field, test_map)
    assert maps.BLACK_QUEEN_MAP == black_queen_map

def test_single_pawn_attacks():

    test_field = FIELD_OBJ['d2']

    test_array_1 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 1, 0, 1, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map =  bit.bitArrayToInt(test_array_1)
    result_map = gen.singlePawnAttacks(test_field, 0)
    assert  test_map == result_map 

    test_field = FIELD_OBJ['a2']

    test_array_2 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 1, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_2)
    result_map =gen.singlePawnAttacks(test_field, 0)
    assert test_map == result_map

    test_field = FIELD_OBJ['f8']

    test_array_3 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_3)
    result_map =gen.singlePawnAttacks(test_field, 0)
    assert test_map == result_map

    test_field = FIELD_OBJ['e6']    

    test_array_4 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 1, 0, 1, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_4)
    result_map = gen.singlePawnAttacks(test_field, 1)
    assert test_map == result_map

    test_field = FIELD_OBJ['h5']    

    test_array_5 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 1, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_5)
    result_map = gen.singlePawnAttacks(test_field, 1)
    assert test_map == result_map

    test_field = FIELD_OBJ['b1']

    test_array_6 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_6)
    result_map = gen.singlePawnAttacks(test_field, 1)
    assert test_map == result_map

def test_single_knight_attacks():
    
    test_field = FIELD_OBJ['e4']    

    test_array_1 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 1, 0, 1, 0, 0,
        0, 0, 1, 0, 0, 0, 1, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 1, 0, 0, 0, 1, 0,
        0, 0, 0, 1, 0, 1, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]
    
    test_map = bit.bitArrayToInt(test_array_1)
    result_map = gen.singleKnightAttacks(test_field)
    assert test_map == result_map

    test_field = FIELD_OBJ['b7']

    test_array_2 = [
        0, 0, 0, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 1, 0, 0, 0, 0,
        1, 0, 1, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_2)
    result_map = gen.singleKnightAttacks(test_field)
    assert test_map == result_map

def test_single_king_attacks():

    test_field = FIELD_OBJ['e4']

    test_array_1 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 1, 1, 1, 0, 0,
        0, 0, 0, 1, 0, 1, 0, 0,
        0, 0, 0, 1, 1, 1, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_1)
    result_map = gen.singleKingAttacks(test_field)
    assert test_map == result_map

    test_field = FIELD_OBJ['a4']

    test_array_2 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        1, 1, 0, 0, 0, 0, 0, 0,
        0, 1, 0, 0, 0, 0, 0, 0,
        1, 1, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_2)
    result_map = gen.singleKingAttacks(test_field)
    assert test_map == result_map
    

def test_single_bishop_attacks():
    
    test_field = FIELD_OBJ['e4']

    test_array_1 = [ 
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 1, 0, 0, 0, 0, 0, 0,
        0, 0, 1, 0, 0, 0, 1, 0,
        0, 0, 0, 1, 0, 1, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 1, 0, 1, 0, 0,
        0, 0, 1, 0, 0, 0, 1, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_1)
    result_map = gen.singleBishopAttacks(test_field)
    assert test_map == result_map

    test_field = FIELD_OBJ['a1']

    test_array_2 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 1, 0,
        0, 0, 0, 0, 0, 1, 0, 0,
        0, 0, 0, 0, 1, 0, 0, 0,
        0, 0, 0, 1, 0, 0, 0, 0,
        0, 0, 1, 0, 0, 0, 0, 0,
        0, 1, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_2)
    result_map = gen.singleBishopAttacks(test_field)
    assert test_map == result_map

def test_single_bishop_attacks_blocked():
    
    test_field = FIELD_OBJ['c6']

    block_array_1 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 1, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 1, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_array_1 = [
        0, 0, 0, 0, 1, 0, 0, 0,
        0, 1, 0, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 1, 0, 1, 0, 0, 0, 0,
        1, 0, 0, 0, 1, 0, 0, 0,
        0, 0, 0, 0, 0, 1, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]
    
    test_map = bit.bitArrayToInt(test_array_1)
    result_map = gen.singleBishopAttacks_blocked(test_field, bit.bitArrayToInt(block_array_1))
    assert test_map == result_map

def test_single_rook_attacks():
    
    test_field = FIELD_OBJ['e4']

    test_array_1 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 1, 0, 0, 0,
        0, 0, 0, 0, 1, 0, 0, 0,
        0, 0, 0, 0, 1, 0, 0, 0,
        0, 1, 1, 1, 0, 1, 1, 0,
        0, 0, 0, 0, 1, 0, 0, 0,
        0, 0, 0, 0, 1, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_1)
    result_map = gen.singleRookAttacks(test_field)
    assert test_map == result_map

    test_field = FIELD_OBJ['a8']

    test_array_2 = [
        0, 1, 1, 1, 1, 1, 1, 0,
        1, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_2)
    result_map = gen.singleRookAttacks(test_field)
    assert test_map == result_map

    test_field = FIELD_OBJ['g2']

    test_array_3 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 1, 0,
        0, 0, 0, 0, 0, 0, 1, 0,
        0, 0, 0, 0, 0, 0, 1, 0,
        0, 0, 0, 0, 0, 0, 1, 0,
        0, 0, 0, 0, 0, 0, 1, 0,
        0, 1, 1, 1, 1, 1, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_3)
    result_map = gen.singleRookAttacks(test_field)
    assert test_map == result_map
    
def test_single_rook_attacks_blocked():
    
    test_field = FIELD_OBJ['f3']

    block_array_1 = [ 
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 1, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_array_1 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 1, 0, 0,
        0, 0, 0, 0, 0, 1, 0, 0,
        0, 0, 0, 0, 0, 1, 0, 0,
        0, 0, 0, 0, 0, 1, 0, 0,
        1, 1, 1, 1, 1, 0, 1, 1,
        0, 0, 0, 0, 0, 1, 0, 0,
        0, 0, 0, 0, 0, 1, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_1)
    result_map = gen.singleRookAttacks_blocked(test_field, bit.bitArrayToInt(block_array_1))
    assert test_map == result_map

    test_field = FIELD_OBJ['h8']

    block_array_2 = [ 
        0, 0, 0, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_array_2 = [
        0, 0, 0, 1, 1, 1, 1, 0,
        0, 0, 0, 0, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_2)
    result_map = gen.singleRookAttacks_blocked(test_field, bit.bitArrayToInt(block_array_2))
    assert test_map == result_map

def test_single_queen_attacks_blocked():
    
    test_field = FIELD_OBJ['f4']

    block_array_1 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 1, 0,
        0, 0, 0, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 1, 0, 0,
        0, 0, 0, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_array_1 = [
        0, 1, 0, 0, 0, 1, 0, 0,
        0, 0, 1, 0, 0, 1, 0, 0,
        0, 0, 0, 1, 0, 1, 0, 0,
        0, 0, 0, 0, 1, 1, 1, 0,
        0, 0, 0, 1, 1, 0, 1, 1,
        0, 0, 0, 0, 1, 1, 1, 0,
        0, 0, 0, 1, 0, 0, 0, 1,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_map = bit.bitArrayToInt(test_array_1)
    result_map = gen.singleQueenAttacks_blocked(test_field, bit.bitArrayToInt(block_array_1))
    assert test_map == result_map

    test_field = FIELD_OBJ['a1']

    block_array_2 = [
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
    ]

    test_array_2 = [
        1, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 1, 0,
        1, 0, 0, 0, 0, 1, 0, 0,
        1, 0, 0, 0, 1, 0, 0, 0,
        1, 0, 0, 1, 0, 0, 0, 0,
        1, 0, 1, 0, 0, 0, 0, 0,
        1, 1, 0, 0, 0, 0, 0, 0,
        0, 1, 1, 1, 1, 1, 1, 1,
    ]

    test_map = bit.bitArrayToInt(test_array_2)
    result_map = gen.singleQueenAttacks_blocked(test_field, bit.bitArrayToInt(block_array_2))
    assert test_map == result_map

# def test_all_attacks_blocked():
   
#     blockMap = bit.fullUnion(maps.ALL_MAPS)
#     attackmaps = gen.allAttacks_blocked(0, blockMap)

#     pawnMaps = attackmaps[0]
#     whitePawnMaps = pawnMaps[0]
#     blackPawnMaps = pawnMaps[1]
    
#     rookMaps = attackmaps[1]
#     knightMaps = attackmaps[2]
#     bishopMaps = attackmaps[3]
#     queenMaps = attackmaps[4]
#     kingMaps = attackmaps[5]

#     for i, pam in enumerate(attackmaps):
#         if i == 0:
#             pass
#         else:
#             if i == 1: print('rook')
#             if i == 2: print('knight')
#             if i == 3: print('bish')
#             if i == 4: print('queen')
#             if i == 5: print('king')
#             for field in pam:
#                 maps.printMap(field)
