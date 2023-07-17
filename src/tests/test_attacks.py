# import numpy as np
# import src.chess.board as board
# import src.chess.bitmethods as bit
# import src.chess.attacks as atk
# import src.chess.maps as maps

# FIELD_OBJ = board.FIELD_OBJ

# def test_single_pawn_attacks():

#     test_field = FIELD_OBJ['d2']

#     test_array_1 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 1, 0, 1, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map =  bit.bitArrayToInt(test_array_1)
#     result_map = atk.singlePawnAttacks(test_field, 0)
#     assert  test_map == result_map 

#     test_field = FIELD_OBJ['a2']

#     test_array_2 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 1, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_2)
#     result_map =atk.singlePawnAttacks(test_field, 0)
#     assert test_map == result_map

#     test_field = FIELD_OBJ['f8']

#     test_array_3 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_3)
#     result_map =atk.singlePawnAttacks(test_field, 0)
#     assert test_map == result_map

#     test_field = FIELD_OBJ['e6']    

#     test_array_4 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 1, 0, 1, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_4)
#     result_map = atk.singlePawnAttacks(test_field, 1)
#     assert test_map == result_map

#     test_field = FIELD_OBJ['h5']    

#     test_array_5 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 1, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_5)
#     result_map = atk.singlePawnAttacks(test_field, 1)
#     assert test_map == result_map

#     test_field = FIELD_OBJ['b1']

#     test_array_6 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_6)
#     result_map = atk.singlePawnAttacks(test_field, 1)
#     assert test_map == result_map

# def test_single_knight_attacks():
    
#     test_field = FIELD_OBJ['e4']    

#     test_array_1 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 1, 0, 1, 0, 0,
#         0, 0, 1, 0, 0, 0, 1, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 1, 0, 0, 0, 1, 0,
#         0, 0, 0, 1, 0, 1, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]
    
#     test_map = bit.bitArrayToInt(test_array_1)
#     result_map = atk.singleKnightAttacks(test_field)
#     assert test_map == result_map

#     test_field = FIELD_OBJ['b7']

#     test_array_2 = [
#         0, 0, 0, 1, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 1, 0, 0, 0, 0,
#         1, 0, 1, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_2)
#     result_map = atk.singleKnightAttacks(test_field)
#     assert test_map == result_map

# def test_single_king_attacks():

#     test_field = FIELD_OBJ['e4']

#     test_array_1 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 1, 1, 1, 0, 0,
#         0, 0, 0, 1, 0, 1, 0, 0,
#         0, 0, 0, 1, 1, 1, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_1)
#     result_map = atk.singleKingAttacks(test_field)
#     assert test_map == result_map

#     test_field = FIELD_OBJ['a4']

#     test_array_2 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         1, 1, 0, 0, 0, 0, 0, 0,
#         0, 1, 0, 0, 0, 0, 0, 0,
#         1, 1, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_2)
#     result_map = atk.singleKingAttacks(test_field)
#     assert test_map == result_map
    

# def test_single_bishop_attacks():
    
#     test_field = FIELD_OBJ['e4']

#     test_array_1 = [ 
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 1, 0, 0, 0, 0, 0, 0,
#         0, 0, 1, 0, 0, 0, 1, 0,
#         0, 0, 0, 1, 0, 1, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 1, 0, 1, 0, 0,
#         0, 0, 1, 0, 0, 0, 1, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_1)
#     result_map = atk.singleBishopMask(test_field)
#     assert test_map == result_map

#     test_field = FIELD_OBJ['a1']

#     test_array_2 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 1, 0,
#         0, 0, 0, 0, 0, 1, 0, 0,
#         0, 0, 0, 0, 1, 0, 0, 0,
#         0, 0, 0, 1, 0, 0, 0, 0,
#         0, 0, 1, 0, 0, 0, 0, 0,
#         0, 1, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_2)
#     result_map = atk.singleBishopMask(test_field)
#     assert test_map == result_map

# def test_single_bishop_attacks_blocked():
    
#     test_field = FIELD_OBJ['c6']

#     block_array_1 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 1, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         1, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 1, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_array_1 = [
#         0, 0, 0, 0, 1, 0, 0, 0,
#         0, 1, 0, 1, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 1, 0, 1, 0, 0, 0, 0,
#         1, 0, 0, 0, 1, 0, 0, 0,
#         0, 0, 0, 0, 0, 1, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]
    
#     test_map = bit.bitArrayToInt(test_array_1)
#     result_map = atk.singleBishopAttacks_otf(test_field, bit.bitArrayToInt(block_array_1))
#     assert test_map == result_map

# def test_single_rook_attacks():
    
#     test_field = FIELD_OBJ['e4']

#     test_array_1 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 1, 0, 0, 0,
#         0, 0, 0, 0, 1, 0, 0, 0,
#         0, 0, 0, 0, 1, 0, 0, 0,
#         0, 1, 1, 1, 0, 1, 1, 0,
#         0, 0, 0, 0, 1, 0, 0, 0,
#         0, 0, 0, 0, 1, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_1)
#     result_map = atk.singleRookMask(test_field)
#     assert test_map == result_map

#     test_field = FIELD_OBJ['a8']

#     test_array_2 = [
#         0, 1, 1, 1, 1, 1, 1, 0,
#         1, 0, 0, 0, 0, 0, 0, 0,
#         1, 0, 0, 0, 0, 0, 0, 0,
#         1, 0, 0, 0, 0, 0, 0, 0,
#         1, 0, 0, 0, 0, 0, 0, 0,
#         1, 0, 0, 0, 0, 0, 0, 0,
#         1, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_2)
#     result_map = atk.singleRookMask(test_field)
#     assert test_map == result_map

#     test_field = FIELD_OBJ['g2']

#     test_array_3 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 1, 0,
#         0, 0, 0, 0, 0, 0, 1, 0,
#         0, 0, 0, 0, 0, 0, 1, 0,
#         0, 0, 0, 0, 0, 0, 1, 0,
#         0, 0, 0, 0, 0, 0, 1, 0,
#         0, 1, 1, 1, 1, 1, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_3)
#     result_map = atk.singleRookMask(test_field)
#     assert test_map == result_map
    
# def test_single_rook_attacks_blocked():
    
#     test_field = FIELD_OBJ['f3']

#     block_array_1 = [ 
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 1, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         1, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_array_1 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 1, 0, 0,
#         0, 0, 0, 0, 0, 1, 0, 0,
#         0, 0, 0, 0, 0, 1, 0, 0,
#         0, 0, 0, 0, 0, 1, 0, 0,
#         1, 1, 1, 1, 1, 0, 1, 1,
#         0, 0, 0, 0, 0, 1, 0, 0,
#         0, 0, 0, 0, 0, 1, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_1)
#     result_map = atk.singleRookAttacks_otf(test_field, bit.bitArrayToInt(block_array_1))
#     assert test_map == result_map

#     test_field = FIELD_OBJ['h8']

#     block_array_2 = [ 
#         0, 0, 0, 1, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 1,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_array_2 = [
#         0, 0, 0, 1, 1, 1, 1, 0,
#         0, 0, 0, 0, 0, 0, 0, 1,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_2)
#     result_map = atk.singleRookAttacks_otf(test_field, bit.bitArrayToInt(block_array_2))
#     assert test_map == result_map

# def test_single_queen_attacks_blocked():
    
#     test_field = FIELD_OBJ['f4']

#     block_array_1 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 1, 0,
#         0, 0, 0, 1, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 1, 0, 0,
#         0, 0, 0, 1, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_array_1 = [
#         0, 1, 0, 0, 0, 1, 0, 0,
#         0, 0, 1, 0, 0, 1, 0, 0,
#         0, 0, 0, 1, 0, 1, 0, 0,
#         0, 0, 0, 0, 1, 1, 1, 0,
#         0, 0, 0, 1, 1, 0, 1, 1,
#         0, 0, 0, 0, 1, 1, 1, 0,
#         0, 0, 0, 1, 0, 0, 0, 1,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_map = bit.bitArrayToInt(test_array_1)
#     result_map = atk.singleQueenAttacks_otf(test_field, bit.bitArrayToInt(block_array_1))
#     assert test_map == result_map

#     test_field = FIELD_OBJ['a1']

#     block_array_2 = [
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#         0, 0, 0, 0, 0, 0, 0, 0,
#     ]

#     test_array_2 = [
#         1, 0, 0, 0, 0, 0, 0, 1,
#         1, 0, 0, 0, 0, 0, 1, 0,
#         1, 0, 0, 0, 0, 1, 0, 0,
#         1, 0, 0, 0, 1, 0, 0, 0,
#         1, 0, 0, 1, 0, 0, 0, 0,
#         1, 0, 1, 0, 0, 0, 0, 0,
#         1, 1, 0, 0, 0, 0, 0, 0,
#         0, 1, 1, 1, 1, 1, 1, 1,
#     ]

#     test_map = bit.bitArrayToInt(test_array_2)
#     result_map = atk.singleQueenAttacks_otf(test_field, bit.bitArrayToInt(block_array_2))
#     assert test_map == result_map

# def test_rook_attack_permutations():

#     test_field = maps.FIELD_OBJ['a1']
#     attackMap = atk.singleRookMask(test_field)

#     # number of permutations in rook attacks
#     for i in range(4096):
#         permutationMap = atk.attackPermutations(i, attackMap)
#         maps.printMap(permutationMap)

# def test_bishop_attack_permutations():

#     test_field = maps.FIELD_OBJ['a1']
#     attackMap = atk.singleBishopMask(test_field)

#     # number of permutations in rook attacks
#     for i in range(512):
#         permutationMap = atk.attackPermutations(i, attackMap)
#         maps.printMap(permutationMap)

# def test_generate_slider_attacks_magic():
#     atk.generateSliderAttacks_magic()

# def test_magic():
    # print(atk.getRookAttack_magic())
    # print(atk.getBishopAttacks_magic())
    # rook_field = board.FIELD_OBJ['a1']
    # bishop_field = board.FIELD_OBJ['e3']

    # newBoard = board.Board()
    # newBoard.fenGameSetup("r2qk2r/p1ppn1pp/bpnb1p2/4p3/4P3/2NPBN2/PPP1BPPP/R2Q1RK1 w kq - - -")

    # newBoard.printBoard()
    # maps.printMap(atk.getBishopAttack_magic(bishop_field, newBoard.board_union))
    # maps.printMap(atk.getRookAttack_magic(rook_field, newBoard.board_union))