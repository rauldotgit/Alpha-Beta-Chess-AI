import numpy as np
import cython
import src.chess.maps as maps
import src.chess.bitmethods as bm
import src.chess.movegen as mg


###########################################################
# TODO: Change movegen functions to take the board and it's data as an input
# TODO: Adjust tests for new functions in board 
# TODO: Fix all variable names to follow a standard
# TODO: Clean up file and module structure
# TODO: Clean up move function
# TODO: Initialize and check for enpassant

##########################################################


class Board():

    white_pawns = 0
    white_rooks = 0
    white_knights = 0
    white_bishops = 0
    white_queen = 0
    white_king = 0

    black_pawns = 0
    black_rooks = 0
    black_knights = 0
    black_bishops = 0
    black_queen = 0
    black_king = 0

    white_maps = [
                white_pawns,
                white_rooks,
                white_knights,
                white_bishops,
                white_queen,
                white_king
                ]
    
    black_maps = [ 
                black_pawns,
                black_rooks,
                black_knights,
                black_bishops,
                black_queen,
                black_king
                ]
    
    all_maps = [
                white_pawns,
                white_rooks,
                white_knights,
                white_bishops,
                white_queen,
                white_king,
                black_pawns,
                black_rooks,
                black_bishops,
                black_knights,
                black_queen,
                black_king
                ]
    
    union_map = 0

    # 0 white 1 black
    turn = 0

    pawn_attacks = []
    rook_attacks = []
    knight_attacks = []
    bishop_attacks = []
    queen_attacks = []
    king_attacks = []

    def __init__(self):
        self.setPieces()

    def nextTurn(self):
        self.turn = 0 if self.turn == 1 else 1

    def setPieces(self):
        self.white_pawns = maps.WHITE_PAWNS_MAP
        self.white_rooks = maps.WHITE_ROOKS_MAP
        self.white_knights = maps.WHITE_KNIGHTS_MAP
        self.white_bishops = maps.WHITE_BISHOPS_MAP
        self.white_queen = maps.WHITE_QUEEN_MAP
        self.white_king = maps.WHITE_KING_MAP

        self.black_pawns = maps.BLACK_PAWNS_MAP
        self.black_rooks = maps.BLACK_ROOKS_MAP
        self.black_knights = maps.BLACK_KNIGHTS_MAP
        self.black_bishops = maps.BLACK_BISHOPS_MAP
        self.black_queen = maps.BLACK_QUEEN_MAP
        self.black_king = maps.BLACK_KING_MAP

    def resetBoard(self):
        self.setPieces()
        self.turn = 0
