from operator import itemgetter
import numpy as np
import cython
import random
import time 

import src.chess.maps as maps
import src.chess.bitmethods as bit
import src.chess.attacks as atk
import src.chess.move_encoding as menc

###########################################################

cdef int noSquare = 64

cdef enum color_int:
    white, black

cdef enum field_int:
    a8, b8, c8, d8, e8, f8, g8, h8,
    a7, b7, c7, d7, e7, f7, g7, h7,
    a6, b6, c6, d6, e6, f6, g6, h6,
    a5, b5, c5, d5, e5, f5, g5, h5,
    a4, b4, c4, d4, e4, f4, g4, h4,
    a3, b3, c3, d3, e3, f3, g3, h3,
    a2, b2, c2, d2, e2, f2, g2, h2,
    a1, b1, c1, d1, e1, f1, g1, h1

cdef enum role_int:
    P, R, N, B, Q, K, p, r, n, b, q, k

cdef enum castle_int:
    wk = 1
    wq = 2
    bk = 4 
    bq = 8

FIELD_ARRAY = [
    'a8', 'b8', 'c8', 'd8', 'e8', 'f8', 'g8', 'h8',
    'a7', 'b7', 'c7', 'd7', 'e7', 'f7', 'g7', 'h7',
    'a6', 'b6', 'c6', 'd6', 'e6', 'f6', 'g6', 'h6',
    'a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5', 'h5',
    'a4', 'b4', 'c4', 'd4', 'e4', 'f4', 'g4', 'h4',
    'a3', 'b3', 'c3', 'd3', 'e3', 'f3', 'g3', 'h3',
    'a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2',
    'a1', 'b1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1',
    ]

MIRROR_FIELD_ARRAY = [
	a1, b1, c1, d1, e1, f1, g1, h1,
	a2, b2, c2, d2, e2, f2, g2, h2,
	a3, b3, c3, d3, e3, f3, g3, h3,
	a4, b4, c4, d4, e4, f4, g4, h4,
	a5, b5, c5, d5, e5, f5, g5, h5,
	a6, b6, c6, d6, e6, f6, g6, h6,
	a7, b7, c7, d7, e7, f7, g7, h7,
	a8, b8, c8, d8, e8, f8, g8, h8
]

CASTLING_ARRAY = [
	 7, 15, 15, 15,  3, 15, 15, 11,
	15, 15, 15, 15, 15, 15, 15, 15,
	15, 15, 15, 15, 15, 15, 15, 15,
	15, 15, 15, 15, 15, 15, 15, 15,
	15, 15, 15, 15, 15, 15, 15, 15,
	15, 15, 15, 15, 15, 15, 15, 15,
	15, 15, 15, 15, 15, 15, 15, 15,
	13, 15, 15, 15, 12, 15, 15, 14,
]

# TODO: change bishop and knight weight
#based on role array
SCORE_ARRAY = [
	100,
	300,
	350,
	500,
	1000,
	10000,
	-100,
	-300,
	-350,
	-500,
	-1000,
	-10000,
]

# evaluation scores
cdef int[64] pawnScores =  [
    0,  0,  0,  0,  0,  0,  0,  0,
    50, 50, 50, 50, 50, 50, 50, 50,
    10, 10, 20, 30, 30, 20, 10, 10,
    5,  5, 10, 25, 25, 10,  5,  5,
    0,  0,  0, 20, 20,  0,  0,  0,
    5, -5,-10,  0,  0,-10, -5,  5,
    5, 10, 10,-20,-20, 10, 10,  5,
    0,  0,  0,  0,  0,  0,  0,  0
]
cdef int[64] rookScores = [
     0,  0,  0,  0,  0,  0,  0,  0,
     5, 10, 10, 10, 10, 10, 10,  5,
    -5,  0,  0,  0,  0,  0,  0, -5,
    -5,  0,  0,  0,  0,  0,  0, -5,
    -5,  0,  0,  0,  0,  0,  0, -5,
    -5,  0,  0,  0,  0,  0,  0, -5,
    -5,  0,  0,  0,  0,  0,  0, -5,
     0,  0,  0,  5,  5,  0,  0,  0
]

cdef int[64] knightScores =  [
    -50,-40,-30,-30,-30,-30,-40,-50,
    -40,-20,  0,  0,  0,  0,-20,-40,
    -30,  0, 10, 15, 15, 10,  0,-30,
    -30,  5, 15, 20, 20, 15,  5,-30,
    -30,  0, 15, 20, 20, 15,  0,-30,
    -30,  5, 10, 15, 15, 10,  5,-30,
    -40,-20,  0,  5,  5,  0,-20,-40,
    -50,-40,-30,-30,-30,-30,-40,-50,
]

cdef int[64] bishopScores =  [
    -20,-10,-10,-10,-10,-10,-10,-20,
    -10,  0,  0,  0,  0,  0,  0,-10,
    -10,  0,  5, 10, 10,  5,  0,-10,
    -10,  5,  5, 10, 10,  5,  5,-10,
    -10,  0, 10, 10, 10, 10,  0,-10,
    -10, 10, 10, 10, 10, 10, 10,-10,
    -10,  5,  0,  0,  0,  0,  5,-10,
    -20,-10,-10,-10,-10,-10,-10,-20,
]


cdef int[64] queenScores =  [
    -20,-10,-10, -5, -5,-10,-10,-20,
    -10,  0,  0,  0,  0,  0,  0,-10,
    -10,  0,  5,  5,  5,  5,  0,-10,
     -5,  0,  5,  5,  5,  5,  0, -5,
      0,  0,  5,  5,  5,  5,  0, -5,
    -10,  5,  5,  5,  5,  5,  0,-10,
    -10,  0,  5,  0,  0,  0,  0,-10,
    -20,-10,-10, -5, -5,-10,-10,-20
]

# TODO: Play around with theses, maybe with an optimization function
cdef int[64] kingScores =  [
    -50,-40,-30,-20,-20,-30,-40,-50,
    -30,-20,-10,  0,  0,-10,-20,-30,
    -30,-10, 20, 30, 30, 20,-10,-30,
    -30,-10, 30, 1001, 1001, 30,-10,-30,
    -30,-10, 30, 1001, 1001, 30,-10,-30,
    -30,-10, 20, 30, 30, 20,-10,-30,
    -30,-30,  0,  0,  0,  0,-30,-30,
    -50,-30,-30,-30,-30,-30,-30,-50
]

cdef int[6][6] MVV_LVA_ARRAY = [
    [105, 205, 305, 405, 505, 605],
    [104, 204, 304, 404, 504, 604],
    [103, 203, 303, 403, 503, 603],
    [102, 202, 302, 402, 502, 602],
    [101, 201, 301, 401, 501, 601],
    [100, 200, 300, 400, 500, 600]
]


FIELD_OBJ = {
		'a8':  0, 'b8':  1, 'c8':  2, 'd8':  3, 'e8':  4, 'f8':  5, 'g8':  6, 'h8':  7,
		'a7':  8, 'b7':  9, 'c7': 10, 'd7': 11, 'e7': 12, 'f7': 13, 'g7': 14, 'h7': 15,
		'a6': 16, 'b6': 17, 'c6': 18, 'd6': 19, 'e6': 20, 'f6': 21, 'g6': 22, 'h6': 23,
		'a5': 24, 'b5': 25, 'c5': 26, 'd5': 27, 'e5': 28, 'f5': 29, 'g5': 30, 'h5': 31,
		'a4': 32, 'b4': 33, 'c4': 34, 'd4': 35, 'e4': 36, 'f4': 37, 'g4': 38, 'h4': 39,
		'a3': 40, 'b3': 41, 'c3': 42, 'd3': 43, 'e3': 44, 'f3': 45, 'g3': 46, 'h3': 47,
		'a2': 48, 'b2': 49, 'c2': 50, 'd2': 51, 'e2': 52, 'f2': 54, 'g2': 54, 'h2': 55,
		'a1': 56, 'b1': 57, 'c1': 58, 'd1': 59, 'e1': 60, 'f1': 62, 'g1': 62, 'h1': 63,
}

ROLE_OBJ = {
	'P': 0,
	'R': 1,
	'N': 2,
	'B': 3,
	'Q': 4,
	'K': 5,
	'p': 6,
	'r': 7,
	'n': 8,
	'b': 9,
	'q': 10,
	'k': 11
}

CASTLE_OBJ = {
	'K': 1,
	'Q': 2,
	'k': 4,
	'q': 8,
}

cdef fieldStr(field_int):
    return FIELD_ARRAY[field_int]

cdef roleUnicode(role_int):
    return maps.ALL_UNICODES[role_int]

cdef forceGet(array, i):
    length = len(array)
    return None if i >= length else array[i]

def printOtherMoveList(moveList):
    if len(moveList) == 0:
        print('Movelist is empty.')
        return

    print(f's->t p  + - d e c')
    for index, move in enumerate(moveList):
        start, target, piece, promoted, capture, doublePush, enpassant, castling = move
        print(
            f'{fieldStr(start)}{fieldStr(target)} {roleUnicode(piece)}  {promoted} {capture} {doublePush} {enpassant} {castling}'
        )

def parseCastle(castleString):
    castleInt = 0
    if castleString == '-': return castleInt

    for char in castleString:
        castleInt |= CASTLE_OBJ[char]

    return castleInt

def fenToBoardInfo(fenString):
    fenArgs = fenString.split()

    if len(fenArgs) != 6:
        raise ValueError("FEN String is missing arguments.")
        return

    fenBoard = fenArgs[0]
    fenTurn = fenArgs[1]
    fenCastle = fenArgs[2]
    fenEnpass = fenArgs[3]
    fenHalf = fenArgs[4]
    fenFull = fenArgs[5]

    pieceMaps = maps.fenBoardToBitMaps(fenBoard)
    turn = 0 if fenTurn == 'w' else 1
    castling = parseCastle(fenCastle)
    enpassant = 64 if fenEnpass == '-' else FIELD_OBJ[fenEnpass]
    halfMoves = 0 if fenHalf == '-' else int(fenHalf)
    fullMoves = 0 if fenFull == '-' else int(fenFull)

    return [pieceMaps, turn, castling, enpassant, halfMoves, fullMoves]

################### GLOBALS #########################

class Board():

    turn = white
    enpassant = noSquare
    castling = 0
    halfMoves = 0
    fullMoves = 0

    # indexed by role_int enum further up
    pieceMaps = [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
    ]

    board_union = 0
    white_board_union = 0
    black_board_union = 0

    moveList = []
    moveIndex = -1

    # this will have all variables from turn ... moveIndex from the last turn
    prevState = []

    #list with time items
    time = []
    
    def __init__(self):
        self.resetBoard()

    def nextTurn(self):
        self.turn = black if self.turn == white else white

    def printBoard(self):
        maps.ppBitMaps(self.pieceMaps)
        print(f'T:{self.turn} C:{self.castling} E:{self.enpassant}')

    def loadSaveState(self, saveState):
        self.turn = saveState[0]
        self.enpassant = saveState[1]
        self.castling = saveState[2]
        self.halfMoves = saveState[3]
        self.fullMoves = saveState[4]

        self.pieceMaps[P] = saveState[5]
        self.pieceMaps[R] = saveState[6]
        self.pieceMaps[N] = saveState[7]
        self.pieceMaps[B] = saveState[8]
        self.pieceMaps[Q] = saveState[9]
        self.pieceMaps[K] = saveState[10]

        self.pieceMaps[p] = saveState[11]
        self.pieceMaps[r] = saveState[12]
        self.pieceMaps[n] = saveState[13]
        self.pieceMaps[b] = saveState[14]
        self.pieceMaps[q] = saveState[15]
        self.pieceMaps[k] = saveState[16]

        self.board_union = saveState[17]
        self.white_board_union = saveState[18]
        self.black_board_union = saveState[19]

        self.moveList = saveState[20]
        self.moveIndex = saveState[21]

        self.time = saveState[22]

    def loadPrevState(self):
        self.turn = self.prevState[0]
        self.enpassant = self.prevState[1]
        self.castling = self.prevState[2]
        self.halfMoves = self.prevState[3]
        self.fullMoves = self.prevState[4]

        self.pieceMaps[P] = self.prevState[5]
        self.pieceMaps[R] = self.prevState[6]
        self.pieceMaps[N] = self.prevState[7]
        self.pieceMaps[B] = self.prevState[8]
        self.pieceMaps[Q] = self.prevState[9]
        self.pieceMaps[K] = self.prevState[10]

        self.pieceMaps[p] = self.prevState[11]
        self.pieceMaps[r] = self.prevState[12]
        self.pieceMaps[n] = self.prevState[13]
        self.pieceMaps[b] = self.prevState[14]
        self.pieceMaps[q] = self.prevState[15]
        self.pieceMaps[k] = self.prevState[16]

        self.board_union = self.prevState[17]
        self.white_board_union = self.prevState[18]
        self.black_board_union = self.prevState[19]

        self.moveList = self.prevState[20]
        self.moveIndex = self.prevState[21]

        self.time = self.prevState[22]

    def saveCurrentState(self):
        self.prevState = [
            self.turn,
            self.enpassant,
            self.castling,
            self.halfMoves,
            self.fullMoves,

            self.pieceMaps[P],
            self.pieceMaps[R],
            self.pieceMaps[N],
            self.pieceMaps[B],
            self.pieceMaps[Q],
            self.pieceMaps[K],
            self.pieceMaps[p],
            self.pieceMaps[r],
            self.pieceMaps[n],
            self.pieceMaps[b],
            self.pieceMaps[q],
            self.pieceMaps[k],

            self.board_union,
            self.white_board_union,
            self.black_board_union,
            
            self.moveList,
            self.moveIndex,

            self.time
        ]

    def getSaveState(self):
        return [
            self.turn,
            self.enpassant,
            self.castling,
            self.halfMoves,
            self.fullMoves,

            self.pieceMaps[P],
            self.pieceMaps[R],
            self.pieceMaps[N],
            self.pieceMaps[B],
            self.pieceMaps[Q],
            self.pieceMaps[K],
            self.pieceMaps[p],
            self.pieceMaps[r],
            self.pieceMaps[n],
            self.pieceMaps[b],
            self.pieceMaps[q],
            self.pieceMaps[k],

            self.board_union,
            self.white_board_union,
            self.black_board_union,
            
            self.moveList,
            self.moveIndex,

            self.time
        ]

    def setPieces(self):
        self.pieceMaps[P] = maps.WHITE_PAWNS_MAP
        self.pieceMaps[R] = maps.WHITE_ROOKS_MAP
        self.pieceMaps[N] = maps.WHITE_KNIGHTS_MAP
        self.pieceMaps[B] = maps.WHITE_BISHOPS_MAP
        self.pieceMaps[Q] = maps.WHITE_QUEEN_MAP
        self.pieceMaps[K] = maps.WHITE_KING_MAP

        self.pieceMaps[p]= maps.BLACK_PAWNS_MAP
        self.pieceMaps[r]= maps.BLACK_ROOKS_MAP
        self.pieceMaps[n]= maps.BLACK_KNIGHTS_MAP
        self.pieceMaps[b]= maps.BLACK_BISHOPS_MAP
        self.pieceMaps[q]= maps.BLACK_QUEEN_MAP
        self.pieceMaps[k]= maps.BLACK_KING_MAP

    def getWhiteMaps(self):
        return self.pieceMaps[0:6]

    def getBlackMaps(self):
        return self.pieceMaps[6:]

    def getPieceMaps(self):
        return self.pieceMaps

    def resetBoard(self):
        self.setPieces()
        self.turn = white

        self.castling = 0
        self.enpassant = noSquare
        self.halfMoves = 0
        self.fullMoves = 0

        self.setBoardUnion()
        self.setSideUnions()
        self.updateSliderAttacks_otf()

        self.moveList = []
        self.moveIndex = -1

        self.time = [3000, 3000]

    def setSideUnions(self):
        self.white_board_union = bit.fullUnion(self.getWhiteMaps())
        self.black_board_union = bit.fullUnion(self.getBlackMaps())

    def setBoardUnion(self):
        self.board_union = bit.fullUnion(self.pieceMaps)

    def setGameDuration(self, tInSec):
        self.time = [tInSec, tInSec]

    def reduceTime(self, startTime):
        endTime = time.time()
        tInSec = endTime - startTime
        newDuration = self.time[not self.turn] - tInSec
        self.time[not self.turn] = newDuration

        return newDuration

    def updateSliderAttacks_otf(self):
        atk.generateSliderAttacks_otf(self.board_union)
    
    def fenGameSetup(self, fenString):
        pieceMaps, turn, castle, enpassant, halfMoves, fullMoves = fenToBoardInfo(fenString)

        self.pieceMaps[P] = pieceMaps[0]
        self.pieceMaps[R] = pieceMaps[1]
        self.pieceMaps[N] = pieceMaps[2]
        self.pieceMaps[B] = pieceMaps[3]
        self.pieceMaps[Q] = pieceMaps[4]
        self.pieceMaps[K] = pieceMaps[5]

        self.pieceMaps[p] = pieceMaps[6]
        self.pieceMaps[r] = pieceMaps[7]
        self.pieceMaps[n] = pieceMaps[8]
        self.pieceMaps[b] = pieceMaps[9]
        self.pieceMaps[q] = pieceMaps[10]
        self.pieceMaps[k] = pieceMaps[11]

        self.turn = turn
        self.castling = castle
        self.enpassant = enpassant
        self.halfMoves = halfMoves
        self.fullMoves = fullMoves

        self.setBoardUnion()
        self.setSideUnions()
        self.updateSliderAttacks_otf()
        self.generateMoves()

    # TODO: copy with magic bitboards when implemented
    # side refers to the attacking side (side == white, get if field is attacked by white)
    def isFieldAttacked(self, fieldIndex, side):
        
        # black is attacked by white pawn, if there's a pawn on the black pawn attack fields (damn)
        isAttackingBlackPawn = atk.getPawnAttack(black, fieldIndex) & self.pieceMaps[P]
        if side == white and isAttackingBlackPawn: return True

        isAttackingWhitePawn = atk.getPawnAttack(white, fieldIndex) & self.pieceMaps[p]
        if side == black and isAttackingWhitePawn: return True
        
        rooksMap = self.pieceMaps[R] if side == white else self.pieceMaps[r]
        if atk.getRookAttack_otf(fieldIndex) & rooksMap: return True

        # a field is attacked by knights, if there are nights around the field in the shape of night attacks (oof)
        knightsMap = self.pieceMaps[N] if side == white else self.pieceMaps[n]
        if atk.getKnightAttack(fieldIndex) & knightsMap: return True

        bishopsMap = self.pieceMaps[B] if side == white else self.pieceMaps[b]
        if atk.getBishopAttack_otf(fieldIndex) & bishopsMap: return True

        queensMap = self.pieceMaps[Q] if side == white else self.pieceMaps[q]
        if atk.getQueenAttack_otf(fieldIndex) & queensMap: return True

        kingsMap = self.pieceMaps[K] if side == white else self.pieceMaps[k]
        if atk.getKingAttack(fieldIndex) & kingsMap: return True

        return False

    def printMove(self, move):
        start, target, piece, promoted, capture, doublePush, enpassant, castling = move
        print(
            f's->t p  + - d e c\n'
            f'{fieldStr(start)}{fieldStr(target)} {roleUnicode(piece)}  {promoted} {capture} {doublePush} {enpassant} {castling}'
        )

    def printMoveList(self):
        if self.moveIndex == -1:
            print('Movelist is empty.')
            return

        print(f's->t p  + - d e c')
        for index, move in enumerate(self.moveList):
            start, target, piece, promoted, capture, doublePush, enpassant, castling = move
            print(
                f'{fieldStr(start)}{fieldStr(target)} {roleUnicode(piece)}  {promoted} {capture} {doublePush} {enpassant} {castling}'
            )
        
        print(f'Number of moves: {self.moveIndex+1}')

    def addMoveToList(self, start, target,  piece, promoted, capture, doublePush, enpassant, castling):
        self.moveList.append([start, target,  piece, promoted, capture, doublePush, enpassant, castling])
        self.moveIndex += 1

    def resetMoveList(self):
        self.moveList = []
        self.moveIndex = -1

    def deleteMove(self, index):
        if self.moveIndex == -1: return
        del self.moveList[index]
        self.moveIndex -= 1

        # returns moveArray and index
    def getRandomMove(self):
        if self.moveIndex == -1: return [], -1
        randIndex = random.randrange(0, self.moveIndex + 1)
        return self.moveList[randIndex], randIndex

    def generateNonPawnMoves(self, pieceMap,  piece):
        while pieceMap:
            start = bit.getLsbIndex(pieceMap)
            
            reverseSideBoardUnion = ~self.white_board_union if self.turn == white else ~self.black_board_union
            pieceAttackMoves = atk.getPieceAttacks_otf(piece)[start] & reverseSideBoardUnion
            
            while pieceAttackMoves:
                target = bit.getLsbIndex(pieceAttackMoves)   
                
                sideBoardUnion = self.black_board_union if self.turn == white else self.white_board_union
                noEnemy = not bit.getBit(sideBoardUnion, target)
                if noEnemy:
                    self.addMoveToList(start, target, piece, 0, 0, 0, 0, 0)
                
                else:
                    self.addMoveToList(start, target, piece, 0, 1, 0, 0, 0)
                
                pieceAttackMoves = bit.popBit(pieceAttackMoves, target)
            
            pieceMap = bit.popBit(pieceMap, start)

    def generateMoves(self):
        cdef int start, target
        self.moveList = []
        self.moveIndex = -1

        for piece, bitmap in enumerate(self.pieceMaps):
            # creating a copy to use
            pieceMap = bitmap

            if self.turn == white:

                isWhitePawns = piece == P
                isWhiteKing = piece == K

                if isWhitePawns:
                    while pieceMap:
                        start = bit.getLsbIndex(pieceMap)
                        target = start - 8

                        startString = fieldStr(start)
                        targetString = fieldStr(target)

                        if not target < a8 and not bit.getBit(self.board_union, target):
                            if start >= a7 and start <= h7:
                                #add move into move list
                                #start, target, piece, promoted, capture, doublePush, enpassant, castling
                                self.addMoveToList(start, target, piece, R, 0, 0, 0, 0)
                                self.addMoveToList(start, target, piece, N, 0, 0, 0, 0)
                                self.addMoveToList(start, target, piece, B, 0, 0, 0, 0)
                                self.addMoveToList(start, target, piece, Q, 0, 0, 0, 0)
 
                            else:
                                #add single pawn move
                                self.addMoveToList(start, target, piece, 0, 0, 0, 0, 0)
                                # add double pawn move 
                                twoTargetString = fieldStr(target - 8)
                                if (start >= a2 and start <= h2) and not bit.getBit(self.board_union, start - 16):
                                    self.addMoveToList(start, target - 8, piece, 0, 0, 1, 0, 0)
                                    

                        # create capturing moves
                        whiteCaptureMoves = atk.getPawnAttack(white, start) & self.black_board_union

                        while whiteCaptureMoves:
                            captureTarget = bit.getLsbIndex(whiteCaptureMoves)

                            #capture combined promotions
                            if start >= a7 and start <= h7:
                                self.addMoveToList(start, captureTarget, piece, R, 1, 0, 0, 0)
                                self.addMoveToList(start, captureTarget, piece, N, 1, 0, 0, 0)
                                self.addMoveToList(start, captureTarget, piece, B, 1, 0, 0, 0)
                                self.addMoveToList(start, captureTarget, piece, Q, 1, 0, 0, 0)
                            else:
                                self.addMoveToList(start, captureTarget, piece, 0, 1, 0, 0, 0)

                            # end of this while loop
                            whiteCaptureMoves = bit.popBit(whiteCaptureMoves, captureTarget)

                        # enpassant captures
                        if self.enpassant != noSquare:
                            enpassantAttacks = atk.getPawnAttack(white, start) & (bit.ONEULL() << self.enpassant)

                            if enpassantAttacks:
                                targetEnpassant = bit.getLsbIndex(enpassantAttacks)
                                self.addMoveToList(start, targetEnpassant, piece, 0, 1, 0, 1, 0)
                        # pop the pawn, as we have calculated everything we need
                        pieceMap = bit.popBit(pieceMap, start)


                ###################################  CASTLE ###################################

                if isWhiteKing:
                    # king side castling 
                    if self.castling & wk:

                        rankRightFree = not bit.getBit(self.board_union, f1) and not bit.getBit(self.board_union, g1)
                        if rankRightFree:
                            
                            rankRightUnattacked = not self.isFieldAttacked(e1, black) and not self.isFieldAttacked(f1, black)
                            if rankRightUnattacked: 
                                self.addMoveToList(e1, g1, piece, 0, 0, 0, 0, 1)
                    
                    if self.castling & wq:

                        rankLeftFree = not bit.getBit(self.board_union, b1) and not bit.getBit(self.board_union, d1) and not bit.getBit(self.board_union, c1)
                        if rankLeftFree:

                            rankLeftUnattacked = not self.isFieldAttacked(e1, black) and not self.isFieldAttacked(d1, black)
                            if rankLeftUnattacked:
                                self.addMoveToList(e1, c1, piece, 0, 0, 0, 0, 1)

            else:
                isBlackPawns = piece == p
                isBlackKing = piece == k

                if isBlackPawns:
                    #pop bits of pawn board until none left and create move option map
                    while pieceMap:
                        #get first pawn
                        start = bit.getLsbIndex(pieceMap)
                        target = start + 8

                        startString = fieldStr(start)
                        targetString = fieldStr(target)

                        # print(bit.getBit(board_union, target))
                        # check if move foward is empty
                        if not (target > h1) and not bit.getBit(self.board_union, target):
                            #promotion
                            if start >= a2 and start <= h2:
                                #add move into move list
                                self.addMoveToList(start, target, piece, r, 0, 0, 0, 0)
                                self.addMoveToList(start, target, piece, n, 0, 0, 0, 0)
                                self.addMoveToList(start, target, piece, b, 0, 0, 0, 0)
                                self.addMoveToList(start, target, piece, q, 0, 0, 0, 0)

                            else:
                                self.addMoveToList(start, target, piece, 0, 0, 0, 0, 0)
                                # double pawn move 
                                if (start >= a7 and start <= h7) and not bit.getBit(self.board_union, start + 16):
                                    self.addMoveToList(start, target + 8, piece, 0, 0, 1, 0, 0)

                        # create capturing moves
                        blackCaptureMoves = atk.getPawnAttack(black, start) & self.white_board_union

                        while blackCaptureMoves:
                            target = bit.getLsbIndex(blackCaptureMoves)

                            #capture combined promotions
                            if start >= a2 and start <= h2:
                                self.addMoveToList(start, target, piece, r, 1, 0, 0, 0)
                                self.addMoveToList(start, target, piece, n, 1, 0, 0, 0)
                                self.addMoveToList(start, target, piece, b, 1, 0, 0, 0)
                                self.addMoveToList(start, target, piece, q, 1, 0, 0, 0)
                            else:
                                self.addMoveToList(start, target, piece, 0, 1, 0, 0, 0)

                            # end of this while loop
                            blackCaptureMoves = bit.popBit(blackCaptureMoves, target)

                        # generate enpassant caputes
                        if self.enpassant != noSquare:
                            enpassantAttacks = atk.getPawnAttack(black, start) & (bit.ONEULL() << self.enpassant)

                            if enpassantAttacks:
                                targetEnpassant = bit.getLsbIndex(enpassantAttacks)
                                self.addMoveToList(start, targetEnpassant, piece, 0, 1, 0, 1, 0)

                        # pop the pawn, as we have calculated everything we need
                        pieceMap = bit.popBit(pieceMap, start)

                ###################################  CASTLE ###################################
                if isBlackKing:
                    # king side castling 
                    if self.castling & bk:

                        rankRightFree = not bit.getBit(self.board_union, f8) and not bit.getBit(self.board_union, g8)
                        if rankRightFree:
                            
                            rankRightUnattacked = not self.isFieldAttacked(e8, white) and not self.isFieldAttacked(f8, white)
                            if rankRightUnattacked: 
                                self.addMoveToList(e8, g8, piece, 0, 0, 0, 0, 1)
                            
                    
                    if self.castling & bq:

                        rankLeftFree = not bit.getBit(self.board_union, b8) and not bit.getBit(self.board_union, d8) and not bit.getBit(self.board_union, c8)
                        if rankLeftFree:

                            rankLeftUnattacked = not self.isFieldAttacked(e8, white) and not self.isFieldAttacked(d8, white)
                            if rankLeftUnattacked:
                                self.addMoveToList(e8, c8, piece, 0, 0, 0, 0, 1)

            isKnightPiece = piece == N if self.turn == white else piece == n
            if isKnightPiece:
                piecemap = self.generateNonPawnMoves(pieceMap, piece)

            isBishopPiece = piece == B if self.turn == white else piece == b
            if isBishopPiece:
                pieceMap = self.generateNonPawnMoves(pieceMap, piece)

            isRookPiece = piece == R if self.turn == white else piece == r
            if isRookPiece:
                pieceMap = self.generateNonPawnMoves(pieceMap, piece)

            isQueenPiece = piece == Q if self.turn == white else piece == q
            if isQueenPiece:
                pieceMap = self.generateNonPawnMoves(pieceMap, piece)

            isKingPiece = piece == K if self.turn == white else piece == k
            if isKingPiece:
                pieceMap = self.generateNonPawnMoves(pieceMap, piece)

    def isCheck(self, kingIndex):
        return self.isFieldAttacked(kingIndex, self.turn)

    def isKOTH(self, kingIndex):
        KOTH = kingIndex == d4 or kingIndex == d5 or kingIndex == e4 or kingIndex == e5
        return True if KOTH else False 

    def makeMove(self, move, flag):
        # 0 all, 1 captures only

        if flag == 0:
            
            # make sure this does what it should
            start, target, piece, promoted, capture, double, enpassant, castle = move
            # self.saveCurrentState()
            saveState = self.getSaveState()
            # print(self.pieceMaps[piece])
            # return

            self.pieceMaps[piece] = bit.popBit(self.pieceMaps[piece], start)
            self.pieceMaps[piece] = bit.setBit(self.pieceMaps[piece], target)

            if capture:
                startPiece = None
                endPiece = None
                
                if self.turn == white:
                    startPiece = p
                    endPiece = k
                else:
                    startPiece = P
                    endPiece = K

                boardPieceIndex = startPiece
                while boardPieceIndex <= endPiece:

                    if bit.getBit(self.pieceMaps[boardPieceIndex], target):
                        self.pieceMaps[boardPieceIndex] = bit.popBit(self.pieceMaps[boardPieceIndex], target)
                        break
                        
                    boardPieceIndex += 1

            if promoted:
                # erase pawn from target
                pawnPiece = P if self.turn == white else p
                self.pieceMaps[pawnPiece] = bit.popBit(self.pieceMaps[pawnPiece], target)
                self.pieceMaps[promoted] = bit.setBit(self.pieceMaps[promoted], target)

            if enpassant:

                if self.turn == white:
                    self.pieceMaps[p] = bit.popBit(self.pieceMaps[p], target + 8)
                else:
                    self.pieceMaps[P] = bit.popBit(self.pieceMaps[P], target - 8)
                
            self.enpassant = noSquare

            if double:

                if self.turn == white:
                    self.enpassant = target + 8
                else:
                    self.enpassant = target - 8

            if castle:

                if target == g1:
                    self.pieceMaps[R] = bit.popBit(self.pieceMaps[R], h1)
                    self.pieceMaps[R] = bit.setBit(self.pieceMaps[R], f1)
                elif target == c1:
                    self.pieceMaps[R] = bit.popBit(self.pieceMaps[R], a1)
                    self.pieceMaps[R] = bit.setBit(self.pieceMaps[R], d1)
                elif target == g8:
                    self.pieceMaps[r] = bit.popBit(self.pieceMaps[r], h8)
                    self.pieceMaps[r] = bit.setBit(self.pieceMaps[r], f8)
                elif target == c8:
                    self.pieceMaps[r] = bit.popBit(self.pieceMaps[r], a8)
                    self.pieceMaps[r] = bit.setBit(self.pieceMaps[r], d8)

            self.castling &= CASTLING_ARRAY[start]
            self.castling &= CASTLING_ARRAY[target]

            self.setBoardUnion()
            self.setSideUnions()
            self.updateSliderAttacks_otf()

            self.nextTurn()
            # self.generateMoves()

            kingIndex = bit.getLsbIndex(self.pieceMaps[k]) if self.turn == white else bit.getLsbIndex(self.pieceMaps[K])
            if self.isCheck(kingIndex):
                # illegal
                self.loadSaveState(saveState)
                return 0
            else:
                if self.isKOTH(kingIndex):
                    return 2
                else:
                    return 1

        else:
            capture = move[4]
            if capture: 
                self.makeMove(move, 0)
            else:
                return 0
    
    # a2b3 e.g.
    # mode 0, require movestring, mode 1, wait for user input
    def parseMove(self, mode, moveString=None):
        
        if mode:
            moveString = input('Input next move.\n')

        if len(moveString) < 4 or len(moveString) > 5:
            return 0

        startString = moveString[0:2]
        targetString = moveString[2:4]

        if not startString in FIELD_OBJ or not targetString in FIELD_OBJ:
            return 0 
        
        inputPromotion = None
        inputStart = FIELD_OBJ[startString]
        inputTarget = FIELD_OBJ[targetString] 

        if len(moveString) == 5:
            inputPromotion = moveString[4].lower()

            if inputPromotion not in ROLE_OBJ:
                return 0


        # print(f'Start: {startString} Target: {targetString} Promotion: {promoString}')

        # TODO: make sure moves are generated ahead of time
        # self.generateMoves(self.turn)

        for move in self.moveList:
            start, target, piece, promoted, capture, double, enpassant, castle = move

            correctCoordinates = inputStart == start and inputTarget == target
            if correctCoordinates:

                if promoted:
                    
                    if (promoted == R or promoted == r) and inputPromotion == 'r':
                        return move
                    if (promoted == N or promoted == n) and inputPromotion == 'n':
                        return move
                    if (promoted == B or promoted == b) and inputPromotion == 'n':
                        return move
                    if (promoted == Q or promoted == q) and inputPromotion == 'q':
                        return move
                    
                    continue

                return move 

            # illegal
            return 0

    # init start position
    # position startpos
    
    # init start position and make the moves on chess board
    # position startpos moves e2e4 e7e5
    
    # init position from FEN string
    # position fen r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq - 0 1 
    
    # init position from fen string and make moves on chess board
    # position fen r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq - 0 1 moves e2a6 e8g8

    # gets a potential capture move from the movelist and returns piece index (P,p .. K,k) of captured piece
    def getCapturedPiece(self, captureField):
        cdef unsigned long long attackBit = 1 << captureField

        # TODO: could be improved by just checking one side 
        for index, pieceMap in enumerate(self.pieceMaps):
            if pieceMap & attackBit:
                return index 

        return -1

    def getCaptureValue(self, move):
        captureField = move[1]
        attackPiece = move[2]
        capturedPiece = self.getCapturedPiece(captureField)
        return MVV_LVA_ARRAY[attackPiece % 6][capturedPiece % 6]

    def getFieldValue(self, piece, fieldIndex):
        pieceScore = 0
        mirrorFieldIndex = MIRROR_FIELD_ARRAY[fieldIndex]

        if   piece == P: pieceScore = pawnScores[fieldIndex] 
        elif piece == R: pieceScore = rookScores[fieldIndex] 
        elif piece == N: pieceScore = knightScores[fieldIndex] 
        elif piece == B: pieceScore = bishopScores[fieldIndex] 
        elif piece == Q: pieceScore = queenScores[fieldIndex] 
        elif piece == K: pieceScore = kingScores[fieldIndex] 

        elif piece == p: pieceScore = -pawnScores[mirrorFieldIndex] 
        elif piece == r: pieceScore = -rookScores[mirrorFieldIndex] 
        elif piece == n: pieceScore = -knightScores[mirrorFieldIndex] 
        elif piece == b: pieceScore = -bishopScores[mirrorFieldIndex] 
        elif piece == q: pieceScore = -queenScores[mirrorFieldIndex] 
        elif piece == k: pieceScore = -kingScores[mirrorFieldIndex] 

        return pieceScore

    def evaluateScore(self):
        score = 0

        for piece, pieceMap in enumerate(self.pieceMaps):
            while pieceMap:
                fieldIndex = bit.getLsbIndex(pieceMap)

                score += SCORE_ARRAY[piece]
                score += self.getFieldValue(piece, fieldIndex)

                pieceMap = bit.popBit(pieceMap, fieldIndex)

        return score if self.turn == white else -score

    def getLegalMoves(self):
        legal = []

        saveState = self.getSaveState()

        for move in self.moveList:
            if not self.makeMove(move, 0):
                continue
            else:
                legal.append(move)
                self.loadSaveState(saveState)

        return legal

    def getLegalMoves_withValues(self):
        legal = []

        saveState = self.getSaveState()

        for move in self.moveList:
            if not self.makeMove(move, 0):
                continue
            else:
                score = self.evaluateScore()
                captureValue = 0
                isCapture = move[4]

                if isCapture:
                    captureValue = self.getCaptureValue(move)    

                legal.append((move, score, captureValue))
                self.loadSaveState(saveState)

        return legal

    # return legal moves, sorted based on score first and capture value second
    def getSortedMoves(self):
        moveList = self.getLegalMoves_withValues()
        return sorted(moveList, key=itemgetter(1,2))


    def parsePosition(self, commandString):
        commandList = commandString.split()
        cmdlen = len(commandList)
        
        # close your eyes here if you're a python dev

        cmd1 = forceGet(commandList, 1)

        if cmd1 and cmd1 == 'startpos':
            self.fenGameSetup(maps.FEN_START)

        elif cmd1 and cmd1 == 'fen':
            fenBoard = forceGet(commandList, 2)
            fenTurn = forceGet(commandList, 3)
            fenCastle = forceGet(commandList, 4)
            fenEnpass = forceGet(commandList, 5)
            fenHalf = forceGet(commandList, 6)
            fenFull = forceGet(commandList, 7)

            if fenBoard != None and fenTurn != None and fenCastle != None and fenEnpass != None and fenHalf != None and fenFull != None: 
                # dumb but works
                self.fenGameSetup(fenBoard + ' ' + fenTurn + ' ' + fenCastle + ' ' + fenEnpass + ' ' + fenHalf + ' ' + fenFull)

                hasMoves = forceGet(commandList, 8)
                if hasMoves:
                    moveList = commandList[8:]

                    for moveString in moveList:
                        legalMove = self.parseMove(0, moveString)

                        print('made move: ' + legalMove)

                        if not legalMove: break

                        self.makeMove(legalMove, 0)
            else:
                print('insufficient fen arguments - will setup start board')
                self.fenGameSetup(maps.FEN_START)
        else:
            print('unknown command')

    # try picking random moves until one works
    def makeRandomMove(self):
        success = 0
        startTime = time.time()
        while not success:
            move, index = self.getRandomMove()
            if move == []:
                return 0
                
            self.printMove(move)
            result = self.makeMove(move, 0)

            timeLeft =self.reduceTime(startTime)

            if timeLeft <= 0:
                self.printBoard()
                return -1

            if result == 1:
                self.printBoard()
                print(f'Score: {-self.evaluateScore()}')
                print(f'Time left: {round(self.time[not self.turn], 3)}s\n')
                return 1
            elif result == 2:
                self.printBoard()
                return 2
            else:
                self.deleteMove(index)

    def makeBetterMove(self):
        startTime = time.time()
        sortedMoves = self.getSortedMoves()
        
        if sortedMoves == []:
            return 0

        move = sortedMoves[0][0]
        self.printMove(move)

        result = self.makeMove(move, 0)
        timeLeft = self.reduceTime(startTime)

        if timeLeft <= 0:
            self.printBoard()
            return -1
        
        if result == 1:
            self.printBoard()
            print(f'Score: {-self.evaluateScore()}')
            print(f'Time left: {round(self.time[not self.turn], 3)}s\n')
        elif result == 2:
            self.printBoard()
            return 2


    ################### ALPHA BETA ###################

    # MVV LVA [attacker][victim]
    mvv_lva = [
        105, 205, 305, 405, 505, 605,  105, 205, 305, 405, 505, 605,
        104, 204, 304, 404, 504, 604,  104, 204, 304, 404, 504, 604,
        103, 203, 303, 403, 503, 603,  103, 203, 303, 403, 503, 603,
        102, 202, 302, 402, 502, 602,  102, 202, 302, 402, 502, 602,
        101, 201, 301, 401, 501, 601,  101, 201, 301, 401, 501, 601,
        100, 200, 300, 400, 500, 600,  100, 200, 300, 400, 500, 600,

        105, 205, 305, 405, 505, 605,  105, 205, 305, 405, 505, 605,
        104, 204, 304, 404, 504, 604,  104, 204, 304, 404, 504, 604,
        103, 203, 303, 403, 503, 603,  103, 203, 303, 403, 503, 603,
        102, 202, 302, 402, 502, 602,  102, 202, 302, 402, 502, 602,
        101, 201, 301, 401, 501, 601,  101, 201, 301, 401, 501, 601,
        100, 200, 300, 400, 500, 600,  100, 200, 300, 400, 500, 600
    ]

    # max self.ply that we can reach within a search
    max_ply = 64

    # killer moves [id][self.ply]
    killer_moves = np.zeros((2, max_ply), dtype=int)

    # history moves [piece][square]
    history_moves = np.zeros((12, 64))

    # PV length [self.ply]
    pv_length = [0 for i in range(max_ply)]

    # PV table [self.ply][self.ply]
    pv_table = np.zeros((max_ply, max_ply))

    # half move counter
    ply = 0

    # nodes
    nodes = 0

    # move -> start, target, piece, promoted, capture, doublePush, enpassant, castling

    # score moves
    def scoreMove(self, move):
        start = move[0]
        target_field = move[1]
        piece = move[2]
        promotion = move[3]
        capture = move[4]

        # score capture move
        if capture:
            # init target_field piece
            print("Target field: ", fieldStr(target_field))
            print("PIECE MAPS")
            for pMap in self.pieceMaps:
                maps.printMap(pMap)
            print("PIECE MAPS END")
            
            target_piece = self.getCapturedPiece(target_field)

            if target_piece == -1:
                print('Piece not found')
                raise ValueError

            return MVV_LVA_ARRAY[piece][target_piece] + 10000 # TODO: maybe move[2] needs to be converted to int        
        
        # score quiet move
        else:
            # score 1st killer move
            if (self.killer_moves[0][self.ply] == menc.encode(*move)): 
                return 9000
            
            # score 2nd killer move
            elif (self.killer_moves[1][self.ply] == menc.encode(*move)):
                return 8000
            
            # score history move
            else:
                print("Piece: ", piece)
                print("Target Field: ", target_field)
                histMove = self.history_moves[piece][target_field]
                print("DEBUGGING SCOREMOVE(): ")
                print("history_moves: ", histMove)
                return histMove # TODO: maybe move[2] needs to be converted to int
        
        return 0

    # sort moves in descending order
    def sortMoves(self): 
        # move scores
        move_scores = np.zeros(len(self.moveList))
        print("DEBUGGING SORTMOVES():")
        print("self.moveList :", self.moveList)
        
        # score all the moves within a move list
        for index, move in enumerate(self.moveList):
            print("DEBUGGING SORTMOVES() LOOP:")
            print("move: ", move)
            # score move
            moveScore = self.scoreMove(move)
            print("DEBUGGING SORTMOVES() LOOP:")
            print(moveScore)
            move_scores[index] = moveScore
        
        # loop over current move within a move list
        for current_index, current_move in enumerate(self.moveList):
            # loop over next move within a move list
            for next_index, next_move in enumerate(self.moveList[1:]):
                # compare current and next move scores
                if (move_scores[current_index] < move_scores[next_index]):
                    # swap scores
                    temp_score = move_scores[current_index]
                    move_scores[current_index] = move_scores[next_index]
                    move_scores[next_index] = temp_score
                    
                    # swap moves
                    temp_move = current_move
                    current_move = next_move
                    next_move = temp_move

    # print move scores
    def printMoveScores(self): 
        print("     Move scores:\n\n");
            
        # loop over moves within a move list
        for move in self.moveList:
            print("     move: ")
            self.printMove(move) 
            print(f' score: {self.scoreMove(move)} \n')

    # quiescence search
    def quiescence(self, alpha, beta):
        # increment nodes count
        self.nodes+=1

        # evaluate position
        evaluation = self.evaluateScore()
        
        # fail-hard beta cutoff
        if (evaluation >= beta):
            # node (move) fails high
            return beta
        
        # found a better move
        if (evaluation > alpha):
            # PV node (move)
            alpha = evaluation
        
        # create move list instance
        #move_list = self.moveList
        
        # generate moves
        #generate_moves(move_list)
        self.generateMoves()
        print("DEBUGGING QUIESCENE():")
        print("generated moves: ", self.moveList)
        
        # sort moves
        #sort_moves(move_list)
        self.sortMoves()
        
        # loop over moves within a movelist
        for move in self.moveList:
            # preserve board state
            self.saveCurrentState()
            
            # increment self.ply
            self.ply+=1
            
            # make sure to make only legal moves
            if self.makeMove(move, 1) == 0:
                # decrement self.ply
                self.ply-=1
                
                # skip to next move
                continue

            # score current move
            score = -self.quiescence(-beta, -alpha)
            
            # decrement self.ply
            self.ply-=1

            # take move back
            self.loadPrevState()
            
            # fail-hard beta cutoff
            if score >= beta:
                # node (move) fails high
                return beta
            
            # found a better move
            if score > alpha:
                # PV node (move)
                alpha = score
        
        # node (move) fails low
        return alpha

    # negamax alpha beta search
    def negamax(self, alpha, beta, depth):
        # init PV length
        self.pv_length[self.ply] = self.ply

        # recursion escape condition
        if depth == 0:
            # run quiescence search
            return self.quiescence(alpha, beta)
        
        # we are too deep, hence there's an overflow of arrays relying on max self.ply constant
        if (self.ply > self.max_ply - 1):
            # evaluate position
            return self.evaluateScore()
        
        # increment nodes count
        self.nodes+=1
        
        # is king in check
        kingIndex = bit.getLsbIndex(self.pieceMaps[k]) if self.turn == white else bit.getLsbIndex(self.pieceMaps[K])
        in_check = self.isCheck(kingIndex)
        
        # increase search depth if the king has been exposed into a check
        if in_check: 
            depth+=1
        
        # legal moves counter
        legal_moves = 0
        
        # create move list instance
        #moves move_list[1];
        
        # generate moves
        #generate_moves(move_list);
        self.generateMoves()
        
        # sort moves
        #sort_moves(move_list);
        self.sortMoves()
        
        # loop over moves within a movelist
        for move in self.moveList:
            # preserve board state
            self.saveCurrentState()
            
            # increment self.ply
            self.ply+=1
            
            # make sure to make only legal moves
            if self.makeMove(move, 0) == 0:
                # decrement self.ply
                self.ply-=1
                
                # skip to next move
                continue
            
            # increment legal moves
            legal_moves+=1
            
            # score current move
            score = -self.negamax(-beta, -alpha, depth - 1)
            
            # decrement self.ply
            self.ply-=1

            # take move back
            self.loadPrevState()
            
            # fail-hard beta cutoff
            if score >= beta:
                # on quiet moves
                if not move[4]:
                    # store killer moves
                    self.killer_moves[1][self.ply] = self.killer_moves[0][self.ply]
                    self.killer_moves[0][self.ply] = menc.encode(*move)
                
                # node (move) fails high
                return beta
            
            # found a better move
            if score > alpha:
                # on quiet moves
                if not move[4]:
                    # store history moves
                    print("depth: ", depth)
                    self.history_moves[move[2]][move[1]] += depth # TODO: maybe move[2] needs to be converted to int
                
                # PV node (move)
                alpha = score
                
                # write PV move
                self.pv_table[self.ply][self.ply] = menc.encode(*move)
                
                # loop over the next self.ply
                #for (int next_ply = self.ply + 1; next_ply < self.pv_length[self.ply + 1]; next_ply++) 
                for next_ply in self.pv_length[self.ply+1:]:
                    # copy move from deeper self.ply into a current self.ply's line
                    self.pv_table[self.ply][next_ply] = self.pv_table[self.ply + 1][next_ply]
                
                # adjust PV length
                self.pv_length[self.ply] = self.pv_length[self.ply + 1]
        
        # we don't have any legal moves to make in the current postion
        if legal_moves == 0:
            # king is in check
            if in_check:
                # return mating score (assuming closest distance to mating position)
                return -49000 + self.ply
            
            # king is not in check
            else:
                # return stalemate score
                return 0
        
        # node (move) fails low
        return alpha

    # search position for the best move
    def searchPosition(self, depth):
        # define best score variable
        score = 0
        
        # reset nodes counter
        self.nodes = 0
        
        # clear helper data structures for search
        self.killer_moves = np.zeros((2, 64))
        self.history_moves = np.zeros((12, 64))
        self.pv_table = np.zeros((64, 64))
        self.pv_length = [0 for i in range(64)]
        
        # iterative deepening
        for current_depth in range(1, depth):
            self.nodes = 0
            
            # find best move within a given position
            score = self.negamax(-50000, 50000, current_depth)
            
            print(f'info score cp {score} depth {current_depth} nodes {self.nodes} pv ')
            
            # loop over the moves within a PV line
            for count in range(0, len(self.pv_length)):
                # print PV move
                print("printMove") # self.printMove(self.pv_table[0][count]) # TODO printMove takes move
                print(" ")
            
            # print new line
            print("\n")

        # best move placeholder
        print("bestmove ")
        print("printMove") # self.printMove(self.pv_table[0][0]) # TODO printMove takes move
        print("\n")
        
        
        
        # reset nodes counter
        self.nodes = 0
        
        # clear helper data structures for search
        self.killer_moves = np.zeros((2, 64))
        self.history_moves = np.zeros((12, 64))
        self.pv_table = np.zeros((64, 64))
        self.pv_length = [0 for i in range(64)]
        
        # find best move within a given position
        score = self.negamax(-50000, 50000, depth)
        
        print(f'info score cp {score} depth {current_depth} nodes {self.nodes} pv ')
        
        # loop over the moves within a PV line
        for count in range(0, len(self.pv_length)):
            # print PV move
            print("printMove") # self.printMove(self.pv_table[0][count]) # TODO printMove takes move
            print(" ")
        
        # print new line
        print("\n")

        # best move placeholder
        print("bestmove ")
        print("printMove") # self.printMove(pv_table[0][0]) # TODO printMove takes move
        print("\n")

    ################### ALPHA BETA END ###################

    def parseBot(self, sleepTime):
        print('botgame')

        self.printBoard()
        print(f'Score: {-self.evaluateScore()}')

        if self.pieceMaps == [0,0,0,0,0,0,0,0,0,0,0,0]:
            self.parsePosition('position startpos')

        while(True):
            print(f'{"white" if self.turn == white else "black"}s turn.')
            self.generateMoves()
            time.sleep(sleepTime)

            # check for opposite side king hill win
            #  if kingOfHill(opponent):

            # result = self.makeRandomMove()
            result = self.makeBetterMove()

            if result == -1:
                winner = 'white' if self.turn == black else 'black'
                print(f'Winner by timeout: {winner}')
                break 

            if result == 0:
                winner = 'white' if self.turn == black else 'black' 
                print(f'Winner by mate or stalemate: {winner}')
                break
            if result == 2:
                winner = 'white' if self.turn == black else 'black' 
                print(f'Winner by KOTH: {winner}')
                break

    def parsePlayer(self):
        print('playerGame')

    # uci parsego
    # go depth 64
    def parseGo(self, command):
        cmdList = command.split()
        depth = -1

        cmdDepth = forceGet(cmdList, 2)

        if cmdDepth and cmdDepth.isnumeric():
            depth = int(cmdDepth)

        # TODO: Time controls 
        else:
            depth = 6

        # TODO: search position
        # searchPosition()

    def uciLoop(self):
        print('\n')
        print('id name TUCM')
        print('id name Konstantin Hasler, Cedric Braun, Raul Nikolaus')

        while(True):
            ui = input()
            
            cmdList = ui.split()
            cmd0 = forceGet(cmdList, 0)

            if cmd0:
                #might not be caught
                if cmd0 == '\n':
                    continue

                elif cmd0 == 'isready':
                    print('readyok')
                    continue

                # position command
                elif cmd0 == 'position':
                    self.parsePosition(ui)

                # ucinewgame command
                elif cmd0 == 'ucinewgame':
                    self.parsePosition("position startpos")

                elif cmd0 == 'go':
                    self.parseGo(ui)

                elif cmd0 == 'bot':
                    cmd1 = forceGet(cmdList, 1)
                    cmd2 = forceGet(cmdList, 2)
                    sleepTime = 0

                    if cmd1 and cmd1 == 'newgame':
                        self.parsePosition('position startpos')

                    if cmd2 and cmd2.isnumeric():
                        sleepTime = int(cmd2)
                        
                    self.parseBot(sleepTime)

                elif cmd0 == 'time':
                    cmd1 = forceGet(cmdList, 1)
                    if cmd1 and cmd1.isnumeric():

                        time = int(cmd1)
                        if time < 0:
                            print('insufficient time setting')
                            continue

                        self.setGameDuration(time)

                elif cmd0 == 'player':
                    cmd1 = forceGet(cmdList, 1)

                    if cmd1 and cmd1 == 'newGame':
                        self.parsePosition('position startpos')
                    
                    self.parsePlayer()

                elif cmd0 == 'quit':
                    break
                
                elif cmd0 == 'uci':
                    print('id name somebot')
                    print('id name somebody')
                    print('uciok')
    





        
        



