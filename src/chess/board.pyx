import numpy as np
import cython
import src.chess.maps as maps
import src.chess.bitmethods as bit
import src.chess.attacks as atk
import src.chess.move_encoding as menc
import random
import time 

###########################################################
# TODO: Fix all variable names to follow a standard
# TODO: Clean up move function
# TODO: Initialize and check for enpassant
# TODO: change all references of allmaps or piecemaps

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

ROLE_ARRAY = maps.ROLE_ARRAY
ROLE_OBJ = maps.ROLE_OBJ
SCORE_ARRAY = maps.SCORE_ARRAY
FIELD_ARRAY = maps.FIELD_ARRAY
FIELD_OBJ = maps.FIELD_OBJ
ALL_UNICODES = maps.ALL_UNICODES 
CASTLING_RIGHTS = maps.CASTLING_RIGHTS

cdef fieldStr(field_int):
    return FIELD_ARRAY[field_int]

cdef roleStr(role_int):
    return ROLE_ARRAY[role_int]

cdef roleUnicode(role_int):
    return ALL_UNICODES[role_int]

cdef forceGet(array, i):
    length = len(array)
    return None if i >= length else array[i]

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

    # careful, pawns are 2d [white/black][field]
    pawnAttacks = []
    rookAttacks = []
    knightAttacks = []
    bishopAttacks = []
    queenAttacks = []
    kingAttacks = []

    moveList = []
    moveIndex = -1

    # this will have all variables from turn ... moveIndex from the last turn
    prevState = []
    
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

        self.pawnAttacks = saveState[20]
        self.rookAttacks = saveState[21]
        self.knightAttacks = saveState[22]
        self.bishopAttacks = saveState[23]
        self.queenAttacks = saveState[24]
        self.kingAttacks = saveState[25]
        self.moveList = saveState[26]
        self.moveIndex = saveState[27]

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

        self.pawnAttacks = self.prevState[20]
        self.rookAttacks = self.prevState[21]
        self.knightAttacks = self.prevState[22]
        self.bishopAttacks = self.prevState[23]
        self.queenAttacks = self.prevState[24]
        self.kingAttacks = self.prevState[25]
        self.moveList = self.prevState[26]
        self.moveIndex = self.prevState[27]

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

            self.pawnAttacks,
            self.rookAttacks,
            self.knightAttacks,
            self.bishopAttacks,
            self.queenAttacks,
            self.kingAttacks,
            
            self.moveList,
            self.moveIndex 
        ]

    def getStateCopy(self):
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

            self.pawnAttacks,
            self.rookAttacks,
            self.knightAttacks,
            self.bishopAttacks,
            self.queenAttacks,
            self.kingAttacks,
            
            self.moveList,
            self.moveIndex 
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

    def getAttackMaps(self):
        return [
            self.pawnAttacks,
            self.rookAttacks,
            self.knightAttacks,
            self.bishopAttacks,
            self.queenAttacks,
            self.kingAttacks
        ]

    def resetBoard(self):
        self.setPieces()
        self.turn = white

        self.castling = 0
        self.enpassant = noSquare
        self.halfMoves = 0
        self.fullMoves = 0

        self.setBoardUnion()
        self.setSideUnions()
        self.generateAttackMaps_NOMAGIC()

        self.moveList = []
        self.moveIndex = -1

    def setSideUnions(self):
        self.white_board_union = bit.fullUnion(self.getWhiteMaps())
        self.black_board_union = bit.fullUnion(self.getBlackMaps())

    def setBoardUnion(self):
        self.board_union = bit.fullUnion(self.pieceMaps)

    # make sure bord union is up to date
    def generateAttackMaps_NOMAGIC(self):
        attackMaps = atk.allAttacks_blocked(self.board_union)

        self.pawnAttacks = attackMaps[0]
        self.rookAttacks = attackMaps[1]
        self.knightAttacks = attackMaps[2]
        self.bishopAttacks = attackMaps[3]
        self.queenAttacks = attackMaps[4]
        self.kingAttacks = attackMaps[5]

    def updateAttackMaps_NOMAGIC(self):
        rookBishopQueenMaps = atk.allSliderAttacks_blocked(self.board_union)

        self.rookAttacks = rookBishopQueenMaps[0]
        self.bishopAttacks = rookBishopQueenMaps[1]
        self.queenAttacks = rookBishopQueenMaps[2]
    
    def fenGameSetup(self, fenString):
        pieceMaps, turn, castle, enpassant, halfMoves, fullMoves = maps.fenToBoardInfo(fenString)

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
        self.generateAttackMaps_NOMAGIC()
        self.generateMoves()

    # TODO: copy with magic bitboards when implemented
    # side refers to the attacking side (side == white, get if field is attacked by white)
    def isFieldAttacked(self, fieldIndex, side):
        
        # black is attacked by white pawn, if there's a pawn on the black pawn attack fields (damn)
        isAttackingBlackPawn = self.pawnAttacks[black][fieldIndex] & self.pieceMaps[P]
        if side == white and isAttackingBlackPawn: return True

        isAttackingWhitePawn = self.pawnAttacks[white][fieldIndex] & self.pieceMaps[p]
        if side == black and isAttackingWhitePawn: return True
        
        rooksMap = self.pieceMaps[R] if side == white else self.pieceMaps[r]
        if self.rookAttacks[fieldIndex] & rooksMap: return True

        # a field is attacked by knights, if there are nights around the field in the shape of night attacks (oof)
        knightsMap = self.pieceMaps[N] if side == white else self.pieceMaps[n]
        if self.knightAttacks[fieldIndex] & knightsMap: return True

        bishopsMap = self.pieceMaps[B] if side == white else self.pieceMaps[b]
        if self.bishopAttacks[fieldIndex] & bishopsMap: return True

        queensMap = self.pieceMaps[Q] if side == white else self.pieceMaps[q]
        if self.queenAttacks[fieldIndex] & queensMap: return True

        kingsMap = self.pieceMaps[K] if side == white else self.pieceMaps[k]
        if self.kingAttacks[fieldIndex] & kingsMap: return True

        return False

    # attacked by side color
    def attackUnion(self, side):
        attackUnion = 0
        attackMaps = self.getAttackMaps()
        colorMaps = self.getBlackMaps() if side == black else self.getWhiteMaps()

        for i, map in enumerate(colorMaps):
            pieceIndices = bit.getBitIndices(map)
            for index in pieceIndices:
                if i == 0:
                    attackUnion |= attackMaps[i][side][index]
                else:
                    attackUnion |= attackMaps[i][index]

        return attackUnion

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
    def getMoveRandom(self):
        if self.moveIndex == -1: return [], -1
        randIndex = random.randrange(0, self.moveIndex + 1)
        return self.moveList[randIndex], randIndex
        

    # def generateNonPawnMove(self, pieceMap, piece):
    #     atkMapsIndex = -1
    #     if piece == R or piece == r: atkMapsIndex = 1
    #     elif piece == N or piece == n: atkMapsIndex = 2
    #     elif piece == B or piece == b: atkMapsIndex = 3
    #     elif piece == Q or piece == q: atkMapsIndex = 4
    #     elif piece == K or piece == k: atkMapsIndex = 5 

    #     while pieceMap:
    #         start = bit.getLsbIndex(pieceMap);
            
    #         reverseSideBoardUnion = ~self.white_board_union if self.turn == white else ~self.black_board_union
    #         pieceAttackMoves = self.attackMaps[atkMapsIndex][start] & reverseSideBoardUnion
            
    #         while pieceAttackMoves:
    #             target = bit.getLsbIndex(pieceAttackMoves);    
                
    #             sideBoardUnion = self.black_board_union if self.turn == white else self.white_board_union
    #             noEnemy = not self.isFieldAttacked(sideBoardUnion, target)

    #             if noEnemy:
    #                 print("piece quiet move ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
    #             else:
    #                 print("piece capture ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
                
    #             pieceAttackMoves = bit.popBit(pieceAttackMoves, target)
            
    #         pieceMap = bit.popBit(pieceMap, start);


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

                        startString = maps.FIELD_ARRAY[start]
                        targetString = maps.FIELD_ARRAY[target]

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
                                twoTargetString = maps.FIELD_ARRAY[target - 8]
                                if (start >= a2 and start <= h2) and not bit.getBit(self.board_union, start - 16):
                                    self.addMoveToList(start, target - 8, piece, 0, 0, 1, 0, 0)
                                    

                        # create capturing moves
                        whiteCaptureMoves = self.pawnAttacks[self.turn][start] & self.black_board_union

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
                            enpassantAttacks = self.pawnAttacks[self.turn][start] & (bit.ONEULL() << self.enpassant)

                            if enpassantAttacks:
                                targetEnpassant = bit.getLsbIndex(enpassantAttacks)
                                self.addMoveToList(start, targetEnpassant, piece, 0, 1, 0, 1, 0)
                        # pop the pawn, as we have calculated everything we need
                        pieceMap = bit.popBit(pieceMap, start)


                ###################################  CASTLE ###################################
                #TODO: Simplify conditional cascading
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

                        startString = maps.FIELD_ARRAY[start]
                        targetString = maps.FIELD_ARRAY[target]

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
                        blackCaptureMoves = self.pawnAttacks[self.turn][start] & self.white_board_union

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
                            enpassantAttacks = self.pawnAttacks[self.turn][start] & (bit.ONEULL() << self.enpassant)

                            if enpassantAttacks:
                                targetEnpassant = bit.getLsbIndex(enpassantAttacks)
                                self.addMoveToList(start, targetEnpassant, piece, 0, 1, 0, 1, 0)

                        # pop the pawn, as we have calculated everything we need
                        pieceMap = bit.popBit(pieceMap, start)

                ###################################  CASTLE ###################################
                #TODO: Simplify conditional cascading
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

            # generate knight moves
            isKnightPiece = piece == N if self.turn == white else piece == n
            if isKnightPiece:
                while pieceMap:
                    start = bit.getLsbIndex(pieceMap);

                    reverseSideBoardUnion = ~self.white_board_union if self.turn == white else ~self.black_board_union
                    knightAttackMoves = self.knightAttacks[start] & reverseSideBoardUnion
                    
                    while knightAttackMoves:
                        target = bit.getLsbIndex(knightAttackMoves);    
                        
                        sideBoardUnion = self.black_board_union if self.turn == white else self.white_board_union
                        noEnemy = not bit.getBit(sideBoardUnion, target)

                        if noEnemy:
                            self.addMoveToList(start, target, piece, 0, 0, 0, 0, 0)
                        else:
                            self.addMoveToList(start, target, piece, 0, 1, 0, 0, 0)
                        
                        knightAttackMoves = bit.popBit(knightAttackMoves, target)
                    
                    pieceMap = bit.popBit(pieceMap, start);
            
            isBishopPiece = piece == B if self.turn == white else piece == b
            if isBishopPiece:
                while pieceMap:
                    start = bit.getLsbIndex(pieceMap)
                    
                    reverseSideBoardUnion = ~self.white_board_union if self.turn == white else ~self.black_board_union
                    bishopAttackMoves = self.bishopAttacks[start] & reverseSideBoardUnion
                    
                    while bishopAttackMoves:
                        target = bit.getLsbIndex(bishopAttackMoves)   
                        
                        sideBoardUnion = self.black_board_union if self.turn == white else self.white_board_union
                        noEnemy = not bit.getBit(sideBoardUnion, target)
                        if noEnemy:
                            self.addMoveToList(start, target, piece, 0, 0, 0, 0, 0)
                        
                        else:
                            self.addMoveToList(start, target, piece, 0, 1, 0, 0, 0)
                        
                        bishopAttackMoves = bit.popBit(bishopAttackMoves, target)
                    
                    pieceMap = bit.popBit(pieceMap, start)
            
            isRookPiece = piece == R if self.turn == white else piece == r
            if isRookPiece:
                while pieceMap:
                    start = bit.getLsbIndex(pieceMap)
                    
                    reverseSideBoardUnion = ~self.white_board_union if self.turn == white else ~self.black_board_union
                    rookAttackMoves = self.rookAttacks[start] & reverseSideBoardUnion

                    while rookAttackMoves:
                        target = bit.getLsbIndex(rookAttackMoves);    
                        
                        sideBoardUnion = self.black_board_union if self.turn == white else self.white_board_union
                        noEnemy = not bit.getBit(sideBoardUnion, target)
                        
                        if noEnemy:
                            self.addMoveToList(start, target, piece, 0, 0, 0, 0, 0)
                        else:
                            self.addMoveToList(start, target, piece, 0, 1, 0, 0, 0)
                        
                        rookAttackMoves = bit.popBit(rookAttackMoves, target)
                    
                    pieceMap = bit.popBit(pieceMap, start)
            
            isQueenPiece = piece == Q if self.turn == white else piece == q
            if isQueenPiece:
                while pieceMap:
                    start = bit.getLsbIndex(pieceMap)
                    
                    reverseSideBoardUnion = ~self.white_board_union if self.turn == white else ~self.black_board_union
                    queenAttackMoves = self.queenAttacks[start] & reverseSideBoardUnion

                    while queenAttackMoves:
                        target = bit.getLsbIndex(queenAttackMoves);    
                        
                        sideBoardUnion = self.black_board_union if self.turn == white else self.white_board_union
                        noEnemy = not bit.getBit(sideBoardUnion, target)
                        
                        if noEnemy:
                            self.addMoveToList(start, target, piece, 0, 0, 0, 0, 0)
                        else:
                            self.addMoveToList(start, target, piece, 0, 1, 0, 0, 0)
                        
                        queenAttackMoves = bit.popBit(queenAttackMoves, target)
                    
                    pieceMap = bit.popBit(pieceMap, start)

            isKingPiece = piece == K if self.turn == white else piece == k
            if isKingPiece:
                while pieceMap:
                    start = bit.getLsbIndex(pieceMap)
                    
                    reverseSideBoardUnion = ~self.white_board_union if self.turn == white else ~self.black_board_union
                    knightAttackMoves = self.kingAttacks[start] & reverseSideBoardUnion

                    while knightAttackMoves:
                        target = bit.getLsbIndex(knightAttackMoves);    
                        
                        sideBoardUnion = self.black_board_union if self.turn == white else self.white_board_union
                        noEnemy = not bit.getBit(sideBoardUnion, target)
                        
                        if noEnemy:
                            self.addMoveToList(start, target, piece, 0, 0, 0, 0, 0)
                        else:
                            self.addMoveToList(start, target, piece, 0, 1, 0, 0, 0)
                        
                        knightAttackMoves = bit.popBit(knightAttackMoves, target)
                    
                    pieceMap = bit.popBit(pieceMap, start)

    def makeMove(self, move, flag):
        # 0 all, 1 captures only

        if flag == 0:
            
            # make sure this does what it should
            start, target, piece, promoted, capture, double, enpassant, castle = move
            self.saveCurrentState()

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

            self.castling &= CASTLING_RIGHTS[start]
            self.castling &= CASTLING_RIGHTS[target]

            self.setBoardUnion()
            self.setSideUnions()
            self.updateAttackMaps_NOMAGIC()

            self.nextTurn()
            # self.generateMoves()

            kingIndex = bit.getLsbIndex(self.pieceMaps[k]) if self.turn == white else bit.getLsbIndex(self.pieceMaps[K])
            isCheck = self.isFieldAttacked(kingIndex, self.turn)
            if isCheck:
                # illegal
                # print('move is in check - revert')
                self.loadPrevState()
                return 0
            else:
                return 1

        else:
            capture = move[4]
            if capture: 
                self.make_move(move, 0)
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

    def returnLegalMoves(self):
        # TODO: Assumes moves are generates
        legal = []

        saveState = self.getStateCopy()

        for move in self.moveList:
            if not self.makeMove(move, 0):
                continue
            else:
                legal.append(move)
                self.loadSaveState(saveState)

        return legal

    def evaluateScore(self):
        score = 0

        for i, piece in enumerate(self.pieceMaps):
            pieceMap = piece
            pieceIndex = i
            while pieceMap:
                fieldIndex = bit.getLsbIndex(pieceMap)
                score += SCORE_ARRAY[pieceIndex]
                pieceMap = bit.popBit(pieceMap, fieldIndex)

        return score if self.turn == white else -score

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
        #change this if needed TODO\

    # try picking random moves until one works
    def makeRandomMove(self):
        success = 0
        while not success:
            move, index = self.getMoveRandom()
            if move == []:
                print('no more moves')
                return 0
                
            self.printMove(move)
            success = self.makeMove(move, 0)

            if success:
                print('success')
                self.printBoard()
                print(f'Score: {self.evaluateScore()}')
                return 1
            else:
                print('failed')
                self.deleteMove(index)
            
    def parseBot(self):
        print('botgame')

        if self.pieceMaps == [0,0,0,0,0,0,0,0,0,0,0,0]:
            self.parsePosition('position startpos')

        while(True):
            print(f'{"white" if self.turn == white else "black"}s turn.')
            time.sleep(1)

            # check for opposite side king hill win
            #  if kingOfHill(opponent):

            ongoing = self.makeRandomMove()
            self.generateMoves()
            if not ongoing:
                winner = white if self.turn == black else black 
                print(f'Winner by check: {winner}')
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

        print('id name TUCM')
        # TODO: add name of contributors 
        print('id name somebody')

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

                    if cmd1 and cmd1 == 'newgame':
                        self.parsePosition('position startpos')
                        
                    self.parseBot()


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
    





        
        



