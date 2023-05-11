import numpy as np
import cython
import src.chess.maps as maps
import src.chess.bitmethods as bit
import src.chess.attacks as atk
import src.chess.move_encoding as menc

###########################################################
# TODO: Change movegen functions to take the board and it's data as an input
# TODO: Adjust tests for new functions in board 
# TODO: Fix all variable names to follow a standard
# TODO: Clean up file and module structure
# TODO: Clean up move function
# TODO: Initialize and check for enpassant

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
    wk, wq, bk, bq 

ROLE_ARRAY = maps.ROLE_ARRAY
FIELD_ARRAY = maps.FIELD_ARRAY

cdef field(field_int):
    return FIELD_ARRAY[field_int]

cdef role(role_int):
    return ROLE_ARRAY[role_int]

################### GLOBALS #########################

class Board():
    turn = white
    enpassant = noSquare
    castling = 0

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

    whiteMaps = [
                white_pawns,
                white_rooks,
                white_knights,
                white_bishops,
                white_queen,
                white_king
                ]
    
    blackMaps = [ 
                black_pawns,
                black_rooks,
                black_knights,
                black_bishops,
                black_queen,
                black_king
                ]
    
    allMaps = [
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

    board_union = 0
    white_board_union = 0
    black_board_union = 0

    # careful, pawns are 2d [white/black][field]
    pawnAttacks = []
    whitePawnAttacks = []
    blackPawnAttacks = []
    rookAttacks = []
    knightAttacks = []
    bishopAttacks = []
    queenAttacks = []
    kingAttacks = []

    attackMaps = [
        pawnAttacks,
        rookAttacks,
        knightAttacks,
        bishopAttacks,
        queenAttacks,
        kingAttacks
    ]

    moveList = []
    moveIndex = -1
    
    def __init__(self):
        self.setPieces()

    def nextTurn(self):
        self.turn = black if self.turn == white else white

    def printBoard(self):
        maps.ppBitMaps(self.allMaps)

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
        self.turn = white

        self.castling = 0
        self.enpassant = noSquare

        self.setBoardUnion()
        self.setSideUnions()
        self.generateAttackMaps_NOMAGIC()

    def setSideUnions(self):
        whiteNp = np.array(self.whiteMaps)
        blackNp = np.array(self.blackMaps)

        white_board_union = bit.fullUnion(whiteNp)
        black_board_union = bit.fullUnion(blackNp)

    def setBoardUnion(self):
        self.board_union = bit.fullUnion(self.allMaps)

    # make sure bord union is up to date
    def generateAttackMaps_NOMAGIC(self):
        attackMaps = atk.allAttacks_blocked(self.boardUnion)

        self.pawnAttacks = attackMaps[0]
        self.whitePawnAttacks = attackMaps[0][0]
        self.blackPawnAttacks = attackMaps[0][1]
        self.rookAttacks = attackMaps[1]
        self.knightAttacks = attackMaps[2]
        self.bishopAttacks = attackMaps[3]
        self.queenAttacks = attackMaps[4]
        self.kingAttacks = attackMaps[5]
    
    def setupGameState(self, fenString, turn, castling, enpassant):
        pieceMaps = maps.fenToBitMaps(fenString)

        self.white_pawns = pieceMaps[0]
        self.white_rooks = pieceMaps[1]
        self.white_knights = pieceMaps[2]
        self.white_bishops = pieceMaps[3]
        self.white_queen = pieceMaps[4]
        self.white_king = pieceMaps[5]

        self.black_pawns = pieceMaps[6]
        self.black_rooks = pieceMaps[7]
        self.black_knights = pieceMaps[8]
        self.black_bishops = pieceMaps[9]
        self.black_queen = pieceMaps[10]
        self.black_king = pieceMaps[11]

        self.turn = turn
        self.castling = castling
        self.enpassant = enpassant

        self.setBoardUnion()
        self.setSideUnions()
        self.generateAttackMaps_NOMAGIC()

    # TODO: copy with magic bitboards when implemented
    # side refers to the attacking side (side == white, get if field is attacked by white)
    def isFieldAttacked(self, fieldIndex, side):

        # black is attacked by white pawn, if there's a pawn on the black pawn attack fields (damn)
        isAttackingBlackPawn = self.blackPawnAttacks[fieldIndex] & self.white_pawns
        if side == white and isAttackingBlackPawn: return True

        isAttackingWhitePawn = self.whitePawnAttacks[fieldIndex] & self.black_pawns
        if side == black and isAttackingWhitePawn: return True
        
        rooksMap = self.white_rooks if side == white else self.black_rooks
        if self.rookAttacks[fieldIndex] & rooksMap: return True

        # a field is attacked by knights, if there are nights around the field in the shape of night attacks (oof)
        knightsMap = self.white_knights if side == white else self.black_knights
        if self.knightAttacks[fieldIndex] & knightsMap: return True

        bishopsMap = self.white_bishops if side == white else self.black_bishops
        if self.bishopAttacks[fieldIndex] & bishopsMap: return True

        queensMap = self.white_queen if side == white else self.black_queen
        if self.queenAttacks[fieldIndex] & queensMap: return True

        kingsMap = self.white_king if side == white else self.black_king
        if self.kingAttacks[fieldIndex] & kingsMap: return True

        return False

    def printMove(self, move):
        start, target, piece, promoted, capture, doublePush, enpassant, castling = move
        print(
            f'Move:\n'
            f'{field(start)} -> {field(target)}\n'
            f'Piece: {role(piece)}\n'
            f'Promoted: {promoted}\n'
            f'Capture: {capture}\n'
            f'Double Push: {doublePush}\n'
            f'Enpassant: {enpassant}\n'
            f'Castling: {castling}\n'
        )

    def printLastMove(self):
        if self.moveIndex == -1:
            print("No moves in list.")
        else:
            lastMove = self.moveList[self.moveIndex]
            self.printMove(lastMove)

    def printMoveList(self):
        for index, move in enumerate(self.moveList):
            start, target, piece, promoted, capture, doublePush, enpassant, castling = move
            print(
                f'Move {index}:\n'
                f'{field(start)} -> {field(target)}\n'
                f'Piece: {role(piece)}\n'
                f'Promoted: {promoted}\n'
                f'Capture: {capture}\n'
                f'Double Push: {doublePush}\n'
                f'Enpassant: {enpassant}\n'
                f'Castling: {castling}\n'
            )

    def addMoveToList(self, start, target,  piece, promoted, capture, doublePush, enpassant, castling):
        self.moveList.append([start, target,  piece, promoted, capture, doublePush, enpassant, castling])
        self.moveIndex += 1

    def resetMoveList(self):
        self.moveList = []
        self.moveIndex = -1

    def generateNonPawnMove(self, pieceMap, piece):
        atkMapsIndex = -1
        if piece == R or piece == r: atkMapsIndex = 1
        elif piece == N or piece == n: atkMapsIndex = 2
        elif piece == B or piece == b: atkMapsIndex = 3
        elif piece == Q or piece == q: atkMapsIndex = 4
        elif piece == K or piece == k: atkMapsIndex = 5 

        while pieceMap:
            start = bit.getLsbIndex(pieceMap);
            
            reverseSideBoardUnion = ~self.white_board_union if self.turn == white else ~self.black_board_union
            pieceAttackMoves = self.attackMaps[atkMapsIndex][start] & reverseSideBoardUnion
            
            while pieceAttackMoves:
                target = bit.getLsbIndex(pieceAttackMoves);    
                
                sideBoardUnion = self.black_board_union if self.turn == white else self.white_board_union
                noEnemy = not self.isFieldAttacked(sideBoardUnion, target)

                if noEnemy:
                    print("piece quiet move ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
                else:
                    print("piece capture ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
                
                pieceAttackMoves = bit.popBit(pieceAttackMoves, target)
            
            pieceMap = bit.popBit(pieceMap, start);


    def generateMoves(self,turn):
        cdef int start, target

        for index, bitmap in enumerate(self.allMaps):
            # creating a copy to use
            pieceMap = bitmap

            if turn == white:

                isWhitePawns = index == P
                isWhiteKing = index == K

                if isWhitePawns:
                    while pieceMap:
                        start = bit.getLsbIndex(pieceMap)
                        target = start - 8

                        startString = maps.FIELD_ARRAY[start]
                        targetString = maps.FIELD_ARRAY[target]

                        if not (target < a8) and not bit.getBit(self.board_union, target):
                            if start >= a7 and start <= h7:
                                #add move into move list
                                print(f'pawn promotion rook {startString}{targetString}r')
                                print(f'pawn promotion knight {startString}{targetString}k')
                                print(f'pawn promotion bishop {startString}{targetString}n')
                                print(f'pawn promotion queen {startString}{targetString}q')

                            else:
                                #add single pawn move
                                print(f'pawn push {startString}{targetString}')
                                # add double pawn move 
                                twoTargetString = maps.FIELD_ARRAY[target - 8]
                                if (start >= a2 and start <= h2) and not bit.getBit(self.board_union, start - 16):
                                    print(f'double pawn push {startString}{twoTargetString}')
                                    

                        # create capturing moves
                        whiteCaptureMoves = self.whitePawnAttacks[start] & self.black_board_union

                        while whiteCaptureMoves:
                            target = bit.getLsbIndex(whiteCaptureMoves)

                            #capture combined promotions
                            if start >= a7 and start <= h7:
                                print(f'pawn capture promotion rook {startString}{targetString}')
                                print(f'pawn capture promotion knight {startString}{targetString}')
                                print(f'pawn capture promotion bishop {startString}{targetString}')
                                print(f'pawn capture promotion queen {startString}{targetString}')
                            else:
                                print(f'pawn capture {startString}{targetString}')

                            # end of this while loop
                            whiteCaptureMoves = bit.popBit(whiteCaptureMoves, target)

                        # enpassant captures
                        if self.enpassant != noSquare:
                            enpassantAttacks = self.whitePawnAttacks[start] & (bit.ONEULL() << self.enpassant)

                            if enpassantAttacks:
                                targetEnpassant = bit.getLsbIndex(enpassantAttacks)
                                enpassantString = maps.FIELD_ARRAY[targetEnpassant]
                                print(f'pawn enpassant capture {startString}{enpassantString}')
                        # pop the pawn, as we have calculated everything we need
                        pieceMap = bit.popBit(pieceMap, start)


                ###################################  CASTLE ###################################
                #TODO: Simplify conditional cascading
                if isWhiteKing:
                    # king side castling 
                    if self.castling & wk:

                        rankRightFree = not bit.getBit(self.board_union, f1) and not bit.getBit(self.board_union, g1)
                        if rankRightFree:
                            
                            rankRightUnattacked = not self.isFieldAttacked(e1, black) and not self.isFieldAttacked(f1, white)
                            if rankRightUnattacked: 
                                print("castling move: e1g1\n")
                                
                            
                    
                    if self.castling & wq:

                        rankLeftFree = not bit.getBit(self.board_union, d1) and not bit.getBit(self.board_union, c1)
                        if rankLeftFree:

                            rankLeftUnattacked = not self.isFieldAttacked(e1, black) and not self.isFieldAttacked(f1, black)
                            if rankLeftUnattacked:
                                print("castling move: e1c1\n")

            else:
                isBlackPawns = index == p
                isBlackKing = index == k

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
                                print(f'pawn promotion rook {startString}{targetString}')
                                print(f'pawn promotion knight {startString}{targetString}')
                                print(f'pawn promotion bishop {startString}{targetString}')
                                print(f'pawn promotion queen {startString}{targetString}')

                            else:
                                print(f'pawn push {startString}{targetString}')
                                # double pawn move 
                                if (start >= a7 and start <= h7) and not bit.getBit(self.board_union, start + 16):
                                    print(f'double pawn push {startString}{maps.FIELD_ARRAY[target + 8]}')

                        # create capturing moves
                        blackCaptureMoves = self.blackPawnAttacks[start] & self.white_board_union

                        while blackCaptureMoves:
                            target = bit.getLsbIndex(blackCaptureMoves)

                            #capture combined promotions
                            if start >= a2 and start <= h2:
                                print(f'pawn capture promotion rook {startString}{targetString}')
                                print(f'pawn capture promotion knight {startString}{targetString}')
                                print(f'pawn capture promotion bishop {startString}{targetString}')
                                print(f'pawn capture promotion queen {startString}{targetString}')
                            else:
                                print(f'pawn capture {startString}{targetString}')

                            # end of this while loop
                            blackCaptureMoves = bit.popBit(blackCaptureMoves, target)

                        # generate enpassant caputes
                        if self.enpassant != noSquare:
                            enpassantAttacks = self.whitePawnAttacks[turn][start] & (bit.ONEULL() << self.enpassant)
                            enpassantString = maps.FIELD_ARRAY[targetEnpassant]

                            if enpassantAttacks:
                                targetEnpassant = bit.getLsbIndex(enpassantAttacks)
                                print(f'pawn enpassant capture {startString}{enpassantString}')

                        # pop the pawn, as we have calculated everything we need
                        pieceMap = bit.popBit(pieceMap, start)

                ###################################  CASTLE ###################################
                #TODO: Simplify conditional cascading
                if isBlackKing:
                    # king side castling 
                    if self.castling & bk:

                        rankRightFree = not bit.getBit(self.board_union, f8) and not bit.getBit(self.board_union, g8)
                        if rankRightFree:
                            
                            rankRightUnattacked = not self.isFieldAttacked(e8, white) and not self.isFieldAttacked(e8, white)
                            if rankRightUnattacked: 
                                print("castling move: e8g8\n")
                            
                    
                    if self.castling & bq:

                        rankLeftFree = not bit.getBit(self.board_union, g8) and not bit.getBit(self.board_union, c8)
                        if rankLeftFree:

                            rankLeftUnattacked = not self.isFieldAttacked(e8, white) and not self.isFieldAttacked(e8, white)
                            if rankLeftUnattacked:
                                print("castling move: e8c8\n")

            # generate knight moves
            isRookPiece = index == R if self.turn == white else index == r
            if isRookPiece:
                while pieceMap:
                    start = bit.getLsbIndex(bitmap);
                    
                    reverseSideBoardUnion = ~self.white_board_union if self.turn == white else ~self.black_board_union
                    knightAttackMoves = self.knightAttacks[start] & reverseSideBoardUnion
                    
                    while knightAttackMoves:
                        target = bit.getLsbIndex(knightAttackMoves);    
                        
                        sideBoardUnion = self.black_board_union if self.turn == white else self.white_board_union
                        noEnemy = not self.isFieldAttacked(sideBoardUnion, target)

                        if noEnemy:
                            print("piece quiet move ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
                        else:
                            print("piece capture ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
                        
                        knightAttackMoves = bit.popBit(knightAttackMoves, target)
                    
                    pieceMap = bit.popBit(pieceMap, start);
            
            isBishopPiece = index == B if self.turn == white else index == b
            if isBishopPiece:
                while pieceMap:
                    start = bit.getLsbIndex(pieceMap)
                    
                    reverseSideBoardUnion = ~self.white_board_union if self.turn == white else ~self.black_board_union
                    bishopAttackMoves = self.bishopAttacks & reverseSideBoardUnion
                    
                    while bishopAttackMoves:
                        target = bit.getLsbIndex(bishopAttackMoves)   
                        
                        sideBoardUnion = self.black_board_union if self.turn == white else self.white_board_union
                        noEnemy = not self.isFieldAttacked(sideBoardUnion, target)
                        if noEnemy:
                            print("piece quiet move ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
                        
                        else:
                            print("piece capture ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
                        
                        bishopAttackMoves = bit.popBit(bishopAttackMoves, target)
                    
                    pieceMap = bit.popBit(pieceMap, start)
            
            isRookPiece = index == R if self.turn == white else index == r
            if isRookPiece:
                while pieceMap:
                    start = bit.getLsbIndex(pieceMap)
                    
                    reverseSideBoardUnion = ~self.white_board_union if self.turn == white else ~self.black_board_union
                    rookAttackMoves = self.bishopAttacks & reverseSideBoardUnion

                    while rookAttackMoves:
                        target = bit.getLsbIndex(rookAttackMoves);    
                        
                        sideBoardUnion = self.black_board_union if self.turn == white else self.white_board_union
                        noEnemy = not self.isFieldAttacked(sideBoardUnion, target)
                        
                        if noEnemy:
                            print("piece quiet move ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
                        else:
                            print("piece capture ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
                        
                        rookAttackMoves = bit.popBit(rookAttackMoves, target)
                    
                    pieceMap = bit.popBit(pieceMap, start)
            
            isQueenPiece = index == Q if self.turn == white else index == q
            if isQueenPiece:
                while pieceMap:
                    start = bit.getLsbIndex(pieceMap)
                    
                    reverseSideBoardUnion = ~self.white_board_union if self.turn == white else ~self.black_board_union
                    queenAttackMoves = self.queenAttacks & reverseSideBoardUnion

                    while queenAttackMoves:
                        target = bit.getLsbIndex(queenAttackMoves);    
                        
                        sideBoardUnion = self.black_board_union if self.turn == white else self.white_board_union
                        noEnemy = not self.isFieldAttacked(sideBoardUnion, target)
                        
                        if noEnemy:
                            print("piece quiet move ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
                        else:
                            print("piece capture ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
                        
                        queenAttackMoves = bit.popBit(queenAttackMoves, target)
                    
                    pieceMap = bit.popBit(pieceMap, start)

            isKingPiece = index == K if self.turn == white else index == k
            if isKingPiece:
                while pieceMap:
                    start = bit.getLsbIndex(pieceMap)
                    
                    reverseSideBoardUnion = ~self.white_board_union if self.turn == white else ~self.black_board_union
                    knightAttackMoves = self.kingAttacks & reverseSideBoardUnion

                    while knightAttackMoves:
                        target = bit.getLsbIndex(knightAttackMoves);    
                        
                        sideBoardUnion = self.black_board_union if self.turn == white else self.white_board_union
                        noEnemy = not self.isFieldAttacked(sideBoardUnion, target)
                        
                        if noEnemy:
                            print("piece quiet move ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
                        else:
                            print("piece capture ", maps.FIELD_OBJ[start], maps.FIELD_OBJ[target])
                        
                        knightAttackMoves = bit.popBit(knightAttackMoves, target)
                    
                    pieceMap = bit.popBit(pieceMap, start)