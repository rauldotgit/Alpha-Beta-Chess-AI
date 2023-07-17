# import src.chess.board as board
# import src.chess.attacks as atk
# import src.chess.maps as maps

# import time 

# # set up two boards
# # generate attacks with magic and otf
# # compare attack arrays for one specific piece type

# def test_magic_attacks():
#     test_fen = "r2q1rk1/ppp2ppp/2n5/2b1PbN1/8/4p3/PPP3PP/RNBQR1K1 w - - 0 1"
#     boardOne = board.Board()
#     boardTwo = board.Board()

#     boardOne.fenGameSetup(test_fen)
#     boardTwo.fenGameSetup(test_fen)
#     # boardOne.printBoard()

#     atk.genAttackMaps()
#     atk.genAttackMaps_otf(boardOne.board_union)

#     for piece in range(12):
#         for field in range(64):
#             magicMap = atk.getPieceAttackMap(piece, field, boardOne.board_union)
#             otfMap = atk.getPieceAttackMap_otf(piece, field)

#             if magicMap != otfMap:
#                 print('Piece: ', maps.PIECE_ARRAY[piece])
#                 print('Field: ', field)

                
#                 print('magicMap')
#                 maps.printMap(magicMap)
#                 print('otfMap')
#                 maps.printMap(otfMap)

# def test_magic_attacks_2():
#     test_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - - - -"
#     boardOne = board.Board()
#     boardTwo = board.Board()

#     boardOne.fenGameSetup(test_fen)
#     boardTwo.fenGameSetup(test_fen)
#     # boardOne.printBoard()

#     atk.genAttackMaps()
#     atk.genAttackMaps_otf(boardOne.board_union)

#     for piece in range(12):
#         for field in range(64):
#             magicMap = atk.getPieceAttackMap(piece, field, boardOne.board_union)
#             otfMap = atk.getPieceAttackMap_otf(piece, field)

#             if magicMap != otfMap:
#                 print('Piece: ', maps.PIECE_ARRAY[piece])
#                 print('Field: ', field)

                
#                 print('magicMap')
#                 maps.printMap(magicMap)
#                 print('otfMap')
#                 maps.printMap(otfMap)

# def test_magic_attacks_3():
#     test_fen = "rnbqk3/p6P/2n1p1P1/1r3p2/8/1PN1K3/P4P2/R1BQ1BNR w q - 0 1"
#     boardOne = board.Board()
#     boardTwo = board.Board()

#     boardOne.fenGameSetup(test_fen)
#     boardTwo.fenGameSetup(test_fen)
#     # boardOne.printBoard()

#     atk.genAttackMaps()
#     atk.genAttackMaps_otf(boardOne.board_union)

#     for piece in range(12):
#         for field in range(64):
#             magicMap = atk.getPieceAttackMap(piece, field, boardOne.board_union)
#             otfMap = atk.getPieceAttackMap_otf(piece, field)

#             if magicMap != otfMap:
#                 print('Piece: ', maps.PIECE_ARRAY[piece])
#                 print('Field: ', field)

                
#                 print('magicMap')
#                 maps.printMap(magicMap)
#                 print('otfMap')
#                 maps.printMap(otfMap)

# def test_magic_attacks_4():
#     test_fen = "r1bqk2r/ppp3pp/5p2/2nPp3/P1Pn2P1/3P1N2/1P2BP1P/RN1Q1RK1 b k - - -"
#     boardOne = board.Board()
#     boardTwo = board.Board()

#     boardOne.fenGameSetup(test_fen)
#     boardTwo.fenGameSetup(test_fen)
#     # boardOne.printBoard()

#     atk.genAttackMaps()
#     atk.genAttackMaps_otf(boardOne.board_union)

#     for piece in range(12):
#         for field in range(64):
#             magicMap = atk.getPieceAttackMap(piece, field, boardOne.board_union)
#             otfMap = atk.getPieceAttackMap_otf(piece, field)

#             if magicMap != otfMap:
#                 print('Piece: ', maps.PIECE_ARRAY[piece])
#                 print('Field: ', field)

                
#                 print('magicMap')
#                 maps.printMap(magicMap)
#                 print('otfMap')
#                 maps.printMap(otfMap)

# def test_magic_attacks_5():
#     test_fen = "rnb1kbnr/p6p/Bp4p1/8/Q4p2/N2qBN2/PP3PPP/R3K2R b kq - 0 1"
#     boardOne = board.Board()
#     boardTwo = board.Board()

#     boardOne.fenGameSetup(test_fen)
#     boardTwo.fenGameSetup(test_fen)
#     # boardOne.printBoard()

#     atk.genAttackMaps()
#     atk.genAttackMaps_otf(boardOne.board_union)

#     for piece in range(12):
#         for field in range(64):
#             magicMap = atk.getPieceAttackMap(piece, field, boardOne.board_union)
#             otfMap = atk.getPieceAttackMap_otf(piece, field)

#             if magicMap != otfMap:
#                 print('Piece: ', maps.PIECE_ARRAY[piece])
#                 print('Field: ', field)

                
#                 print('magicMap')
#                 maps.printMap(magicMap)
#                 print('otfMap')
#                 maps.printMap(otfMap)

# def test_magic_vs_otf():
#     test_fen = "rnb1kbnr/p6p/Bp4p1/8/Q4p2/N2qBN2/PP3PPP/R3K2R b kq - 0 1"
#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     print('\n')

#     sTime = time.time()
#     atk.genAttackMaps_otf(newBoard.board_union)
#     eTime = time.time()

#     print("OTF Startup time: ", eTime - sTime)

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     sTime = time.time()
#     for i in range(20000): 
#         atk.getQueenAttackMap_otf(43)
#         atk.updateAttackMaps_otf(newBoard.board_union)

#     eTime = time.time()

#     print("OTF time: ", eTime - sTime)
    
#     sTime = time.time()
#     atk.genAttackMaps()
#     eTime = time.time()

#     print("MAGIC Startup time: ", eTime - sTime)

#     newBoard = board.Board()
#     newBoard.fenGameSetup(test_fen)

#     sTime = time.time()
#     for j in range(20000):
#         atk.getQueenAttackMap(43, newBoard.board_union)

#     eTime = time.time()

#     print("MAGIC time: ", eTime - sTime)


