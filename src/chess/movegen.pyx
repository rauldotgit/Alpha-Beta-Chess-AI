import bitmethods as bit
import numpy as np
import maps

# if only used in cython file use cdef for functions and define input and output types

cdef unsigned long long NOT_FILE_H = 9187201950435737471
cdef unsigned long long NOT_FILE_GH = 4557430888798830399
cdef unsigned long long NOT_FILE_AB = 18229723555195321596
cdef unsigned long long NOT_FILE_A = 18374403900871474942

cdef enum color:
    white,
    black

cdef enum field_i:
    a8, b8, c8, d8, e8, f8, g8, h8,
    a7, b7, c7, d7, e7, f7, g7, h7,
    a6, b6, c6, d6, e6, f6, g6, h6,
    a5, b5, c5, d5, e5, f5, g5, h5,
    a4, b4, c4, d4, e4, f4, g4, h4,
    a3, b3, c3, d3, e3, f3, g3, h3,
    a2, b2, c2, d2, e2, f2, g2, h2,
    a1, b1, c1, d1, e1, f1, g1, h1

CASTLE_OBJ = {
    'wk': 1,
    'wq': 2,
    'bk': 4,
    'bq': 8 
}

#TODO: belongs on board
cdef int noSquare = 64
cdef int enpassant = c6
cdef int castling = 0

##################### Helper Functions #######################no_sq

cdef unsigned long long ONEULL():
    cdef unsigned long long one = 1
    return one

cdef unsigned long long ZEROULL(): 
    cdef unsigned long long zero = 0
    return zero

def setPiece(fieldIndex, bitmap):
    cdef unsigned long long pieceUnshifted = 1
    return (pieceUnshifted << fieldIndex) | bitmap 

def sideUnion(pieceBitmaps, color):
    pieceMaps = np.array(pieceBitmaps)
    if color == white:
        return bit.fullUnion(pieceBitmaps[0:6])
    else:
        return bit.fullUnion(pieceBitmaps[6:])

def boardUnion(pieceBitmaps):
    return bit.fullUnion(pieceBitmaps)

##################### Attack Masks  #######################

def singlePawnAttacks(fieldIndex, turn):
    cdef unsigned long long attacks = 0
    cdef unsigned long long bitmap = 0

    bitmap = setPiece(fieldIndex, bitmap)

    if not turn:
        if ((bitmap >> 7 & NOT_FILE_A)):
            attacks |= (bitmap >> 7)    
        if ((bitmap >> 9 & NOT_FILE_H)):
            attacks |= (bitmap >> 9)  

    else:
        if ((bitmap << 7 & NOT_FILE_H)):
            attacks |= (bitmap << 7)  
        if ((bitmap << 9 & NOT_FILE_A)):
            attacks |= (bitmap << 9)  

    return attacks 

def singleKnightAttacks(fieldIndex):
    cdef unsigned long long attacks = 0
    cdef unsigned long long bitmap = 0

    bitmap = setPiece(fieldIndex, bitmap)

    if (bitmap >> 17) & NOT_FILE_H:
        attacks |= (bitmap >> 17)
    if (bitmap >> 15) & NOT_FILE_A:
        attacks |= (bitmap >> 15)
    if (bitmap >> 10) & NOT_FILE_GH:
        attacks |= (bitmap >> 10)
    if (bitmap >> 6) & NOT_FILE_AB:
        attacks |= (bitmap >> 6)


    if (bitmap << 17) & NOT_FILE_A:
        attacks |= (bitmap << 17)
    if (bitmap << 15) & NOT_FILE_H:
        attacks |= (bitmap << 15)
    if (bitmap << 10) & NOT_FILE_AB:
        attacks |= (bitmap << 10)
    if (bitmap << 6) & NOT_FILE_GH:
        attacks |= (bitmap << 6)

    return attacks

def singleKingAttacks(fieldIndex):
    cdef unsigned long long attacks = 0
    cdef unsigned long long bitmap = 0

    bitmap = setPiece(fieldIndex, bitmap)

    if bitmap >> 8:
        attacks |= (bitmap >> 8)
    if (bitmap >> 9) & NOT_FILE_H:
        attacks |= (bitmap >> 9)    
    if (bitmap >> 7) & NOT_FILE_A:
        attacks |= (bitmap >> 7)    
    if (bitmap >> 1) & NOT_FILE_H:
        attacks |= (bitmap >> 1)  
          
    if bitmap << 8:
        attacks |= (bitmap << 8)
    if (bitmap << 9) & NOT_FILE_A:
        attacks |= (bitmap << 9)    
    if (bitmap << 7) & NOT_FILE_H:
        attacks |= (bitmap << 7)    
    if (bitmap << 1) & NOT_FILE_A:
        attacks |= (bitmap << 1)   

    return attacks 


def singleBishopAttacks(fieldIndex):
    cdef unsigned long long attacks = 0
    cdef int r, f;
    cdef int fieldRank = fieldIndex / 8
    cdef int fieldFile = fieldIndex % 8

    r = fieldRank + 1
    f = fieldFile + 1

    while r <= 6 and f <= 6:
        attacks |= (ONEULL() << (r * 8 + f))
        r += 1
        f += 1

    r = fieldRank - 1
    f = fieldFile + 1

    while r >= 1 and f <= 6:
        attacks |= (ONEULL() << (r * 8 + f))
        r -= 1
        f += 1

    r = fieldRank + 1
    f = fieldFile - 1

    while r <= 6 and f >= 1:
        attacks |= (ONEULL() << (r * 8 + f))
        r += 1
        f -= 1

    r = fieldRank - 1
    f = fieldFile - 1

    while r >= 1 and f >= 1:
        attacks |= (ONEULL() << (r * 8 + f))
        r -= 1
        f -= 1

    return attacks

def singleBishopAttacks_blocked(fieldIndex, blockMap):
    cdef unsigned long long attacks = 0
    cdef unsigned long long one = 1
    cdef int r, f;
    cdef int fieldRank = fieldIndex / 8
    cdef int fieldFile = fieldIndex % 8

    r = fieldRank + 1
    f = fieldFile + 1

    while r <= 7 and f <= 7:
        attacks |= (ONEULL() << (r * 8 + f))
        if ((ONEULL() << (r * 8 + f)) & blockMap): break
        r += 1
        f += 1

    r = fieldRank - 1
    f = fieldFile + 1

    while r >= 0 and f <= 7:
        attacks |= (ONEULL() << (r * 8 + f))
        if ((ONEULL() << (r * 8 + f)) & blockMap): break
        r -= 1
        f += 1

    r = fieldRank + 1
    f = fieldFile - 1

    while r <= 7 and f >= 0:
        attacks |= (ONEULL() << (r * 8 + f))
        if ((ONEULL() << (r * 8 + f)) & blockMap): break
        r += 1
        f -= 1

    r = fieldRank - 1
    f = fieldFile - 1

    while r >= 0 and f >= 0:
        attacks |= (ONEULL() << (r * 8 + f))
        if ((ONEULL() << (r * 8 + f)) & blockMap): break
        r -= 1
        f -= 1

    return attacks

def singleRookAttacks(fieldIndex):
    cdef unsigned long long attacks = 0
    cdef int r, f
    cdef int fieldRank = fieldIndex / 8
    cdef int fieldFile = fieldIndex % 8

    r = fieldRank + 1
    while r <= 6:
        attacks |= (ONEULL() << (r * 8 + fieldFile))
        r += 1

    r = fieldRank - 1
    while r >= 1:
        attacks |= (ONEULL() << (r * 8 + fieldFile))
        r -= 1

    f = fieldFile + 1
    while f <= 6:
        attacks |= (ONEULL() << (fieldRank * 8 + f))
        f += 1

    f = fieldFile - 1
    while f >= 1:
        attacks |= (ONEULL() << (fieldRank * 8 + f))
        f -= 1

    return attacks

def singleRookAttacks_blocked(fieldIndex, blockMap):
    cdef unsigned long long attacks = 0
    cdef int r, f
    cdef int fieldRank = fieldIndex / 8
    cdef int fieldFile = fieldIndex % 8

    r = fieldRank + 1
    while r <= 7:
        attacks |= (ONEULL() << (r * 8 + fieldFile))
        if ((ONEULL() << (r * 8 + fieldFile)) & blockMap): break
        r += 1

    r = fieldRank - 1
    while r >= 0:
        attacks |= (ONEULL() << (r * 8 + fieldFile))
        if ((ONEULL() << (r * 8 + fieldFile)) & blockMap): break
        r -= 1

    f = fieldFile + 1
    while f <= 7:
        attacks |= (ONEULL() << (fieldRank * 8 + f))
        if ((ONEULL() << (fieldRank * 8 + f)) & blockMap): break
        f += 1

    f = fieldFile - 1
    while f >= 0:
        attacks |= (ONEULL() << (fieldRank * 8 + f))
        if ((ONEULL() << (fieldRank * 8 + f)) & blockMap): break
        f -= 1

    return attacks

# for testing purposes
def singleQueenAttacks(fieldIndex):
    return singleRookAttacks(fieldIndex) | singleBishopAttacks(fieldIndex)

def singleQueenAttacks_blocked(fieldIndex, blockMap):
    return singleRookAttacks_blocked(fieldIndex, blockMap) | singleBishopAttacks_blocked(fieldIndex, blockMap) 

# attack_maps = [pawn_attacks, rook_attacks, knight_attacks, bishop_attacks, queen_attacks, king_attacks]
# all [2][64] sized: 2 sizes (black / white), 64 attack maps for each field 
def allLeaperAttacks(turn):

    cdef unsigned long long pawn_attacks[2][64]
    cdef unsigned long long knight_attacks[64]
    cdef unsigned long long king_attacks[64]

    for field in range(64):
        pawn_attacks[turn][field] = singlePawnAttacks(field, turn)
        pawn_attacks[turn][field] = singlePawnAttacks(field, turn)
        knight_attacks[field] = singleKingAttacks(field)
        king_attacks[field] = singleKingAttacks(field)
        
    return [pawn_attacks, knight_attacks, king_attacks]

def allSliderAttacks():
    
    cdef unsigned long long rook_attacks[64]
    cdef unsigned long long bishop_attacks[64]
    cdef unsigned long long queen_attacks[64]

    for field in range(64):

        rook_attacks[field] = singleRookAttacks(field)
        bishop_attacks[field] = singleBishopAttacks(field)
        queen_attacks[field] = rook_attacks[field] | bishop_attacks[field]

    return [rook_attacks, bishop_attacks, queen_attacks]

def allSliderAttacks_blocked(blockMap):
    
    cdef unsigned long long rook_attacks[64]
    cdef unsigned long long bishop_attacks[64]
    cdef unsigned long long queen_attacks[64]

    # might compute block map here 

    for field in range(64):

        rook_attacks[field] = singleRookAttacks_blocked(field, blockMap)
        bishop_attacks[field] = singleBishopAttacks_blocked(field, blockMap)
        queen_attacks[field] = rook_attacks[field] | bishop_attacks[field]

    return [rook_attacks, bishop_attacks, queen_attacks]

def allAttacks_blocked(turn, blockMap):

    cdef unsigned long long[2][64] pawn_attacks
    cdef unsigned long long[64] knight_attacks
    cdef unsigned long long[64] king_attacks

    cdef unsigned long long[64] rook_attacks
    cdef unsigned long long[64] bishop_attacks
    cdef unsigned long long[64] queen_attacks

    for field in range(64):
        pawn_attacks[turn][field] = singlePawnAttacks(field, turn)
        pawn_attacks[turn][field] = singlePawnAttacks(field, turn)
        knight_attacks[field] = singleKingAttacks(field)
        king_attacks[field] = singleKingAttacks(field)

        rook_attacks[field] = singleRookAttacks_blocked(field, blockMap)
        bishop_attacks[field] = singleBishopAttacks_blocked(field, blockMap)
        queen_attacks[field] = rook_attacks[field] | bishop_attacks[field]
        

    attack_maps = [pawn_attacks, rook_attacks, knight_attacks, bishop_attacks, queen_attacks, king_attacks]
    return attack_maps

# blockMap should in this case be the full union of all pieces (occupancy)
def printAllAttacked_blocked(turn, blockMap):
    attackMaps = allAttacks_blocked(turn, blockMap)
    return bit.fullUnion(attackMaps)

def generatePawnMoves(turn, pawnAttacksCopy, whiteUnion, blackUnion, bothUnion):
    while pawnAttacksCopy:
        start = bit.getLsbIndex(pawnAttacksCopy)

        wTarget = start - 8
        bTarget = start + 8
        target = wTarget if turn == white else bTarget

        wOnBoard = not (target < maps.FIELD_OBJ['a8'])
        bOnBoard = not (target < maps.FIELD_OBJ['h1'])
        onBoard = wOnBoard if turn == white else not bOnBoard

        freeOneForward = not bit.getBit(bothUnion, target)

        if onBoard and freeOneForward:

            wPrePromR = start >= maps.FIELD_OBJ['a7'] and start <= maps.FIELD_OBJ['h7']
            bPrePromR = start >= maps.FIELD_OBJ['a2'] and start <= maps.FIELD_OBJ['h2']
            beforePromRow = wPrePromR if turn == white else bPrePromR

            if beforePromRow:
                # add promotion options
                print('pawn promotion rook')
                print('pawn promotion knight')
                print('pawn promotion bishop')
                print('pawn promotion queen')

            else:
                # add pawn push
                print('pawn push')

                wOnPawnR = start >= maps.FIELD_OBJ['a2'] and start <= maps.FIELD_OBJ['h2']
                bOnPawnR = start >= maps.FIELD_OBJ['a7'] and start <= maps.FIELD_OBJ['h7']
                onPawnRow = wOnPawnR if turn == white else bOnBoard

                twoForwardShift = start - 16 if turn == white else start + 16
                freeTwoForward = not bit.getBit(bothUnion, twoForwardShift)

                if onPawnRow and freeTwoForward:
                    #add double pawn move
                    print('double pawn push')
                    

        # create capturing moves
        colorUnion = whiteUnion if turn == white else blackUnion
        pawnAttacks = pawnAttacks[turn][start] & colorUnion

        while pawnAttacks:
            target = bit.getLsbIndex(pawnAttacks)

            #capture combined promotions
            wPrePromR = start >= maps.FIELD_OBJ['a7'] and start <= maps.FIELD_OBJ['h7']
            bPrePromR = start >= maps.FIELD_OBJ['a2'] and start <= maps.FIELD_OBJ['h2']
            beforePromRow = wPrePromR if turn == white else bPrePromR

            if beforePromRow:
                print('pawn capture promotion rook')
                print('pawn capture promotion knight')
                print('pawn capture promotion bishop')
                print('pawn capture promotion queen')
            else:
                print('pawn capture')

            # end of this while loop
            pawnAttacks = bit.popBit(target)

        # generate enpassant caputes
        if enpassant != noSquare:
            enpassantAttacks = pawnAttacks[turn][start] & (ONEULL() << enpassant)

            if enpassantAttacks:
                targetEnpassant = bit.getLsbIndex(enpassantAttacks)
                print('pawn enpassant capture')

        # pop the pawn, as we have calculated everything we need
        pawnAttacksCopy = bit.popBit(pawnAttacksCopy, start)

# function to check whether a field is attacked by the current turn side
# TODO: change union functions with maps calculated on board
def generateMoves(pieceMaps, turn):
    cdef int start, target

    # TODO: take theses from board
    cdef unsigned long long whiteUnion = sideUnion(pieceMaps, white)
    cdef unsigned long long blackUnion = sideUnion(pieceMaps, black)
    cdef unsigned long long bothUnion = whiteUnion | blackUnion
    attacks = allAttacks_blocked(turn, bothUnion)

    for index, bitmap in enumerate(pieceMaps):
        # creating a copy to use
        pieceMap = bitmap

        if turn == white:
            isWhitePawns = index == 0

            if isWhitePawns:
                while pieceMap:
                    start = bit.getLsbIndex(pieceMap)
                    target = start - 8

                    if not (target < maps.FIELD_OBJ['a8']) and not bit.getBit(bothUnion, target):
                        if start >= maps.FIELD_OBJ['a7'] and start <= maps.FIELD_OBJ['h7']:
                            #add move into move list
                            print(f'pawn promotion rook {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}r')
                            print(f'pawn promotion knight {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}k')
                            print(f'pawn promotion bishop {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}n')
                            print(f'pawn promotion queen {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}q')

                        else:
                            #add single pawn move
                            print(f'pawn push {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')
                            # add double pawn move 
                            if (start >= maps.FIELD_OBJ['a2'] and start <= maps.FIELD_OBJ['h2']) and not bit.getBit(bothUnion, start - 16):
                                print(f'double pawn push {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target - 8]}')
                                

                    # create capturing moves
                    whitePawnAttacks = attacks[0][turn][start] & blackUnion

                    while whitePawnAttacks:
                        target = bit.getLsbIndex(whitePawnAttacks)

                        #capture combined promotions
                        if start >= maps.FIELD_OBJ['a7'] and start <= maps.FIELD_OBJ['h7']:
                            print(f'pawn capture promotion rook {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')
                            print(f'pawn capture promotion knight {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')
                            print(f'pawn capture promotion bishop {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')
                            print(f'pawn capture promotion queen {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')
                        else:
                            print(f'pawn capture {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')

                        # end of this while loop
                        whitePawnAttacks = bit.popBit(whitePawnAttacks, target)

                    # enpassant captures
                    if enpassant != noSquare:
                        enpassantAttacks = attacks[0][turn][start] & (ONEULL() << enpassant)

                        if enpassantAttacks:
                            targetEnpassant = bit.getLsbIndex(enpassantAttacks)
                            print(f'pawn enpassant capture {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[targetEnpassant]}')
                    # pop the pawn, as we have calculated everything we need
                    pieceMap = bit.popBit(pieceMap, start)

        else:
            isBlackPawns = index == 6

            if isBlackPawns:
                #pop bits of pawn board until none left and create move option map
                while pieceMap:
                    #get first pawn
                    start = bit.getLsbIndex(pieceMap)

                    # general move forward is an 8 index shift "left"
                    target = start + 8

                    # print(bit.getBit(bothUnion, target))
                    # check if move foward is empty
                    if not (target > maps.FIELD_OBJ['h1']) and not bit.getBit(bothUnion, target):
                        #promotion
                        if start >= maps.FIELD_OBJ['a2'] and start <= maps.FIELD_OBJ['h2']:
                            #add move into move list
                            print(f'pawn promotion rook {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')
                            print(f'pawn promotion knight {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')
                            print(f'pawn promotion bishop {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')
                            print(f'pawn promotion queen {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')

                        else:
                            print(f'pawn push {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')
                            # double pawn move 
                            if (start >= maps.FIELD_OBJ['a7'] and start <= maps.FIELD_OBJ['h7']) and not bit.getBit(bothUnion, start + 16):
                                print(f'double pawn push {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target + 8]}')

                    # create capturing moves
                    blackPawnAttacks = attacks[0][turn][start] & whiteUnion

                    while blackPawnAttacks:
                        target = bit.getLsbIndex(blackPawnAttacks)

                        #capture combined promotions
                        if start >= maps.FIELD_OBJ['a2'] and start <= maps.FIELD_OBJ['h2']:
                            print(f'pawn capture promotion rook {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')
                            print(f'pawn capture promotion knight {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')
                            print(f'pawn capture promotion bishop {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')
                            print(f'pawn capture promotion queen {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')
                        else:
                            print(f'pawn capture {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[target]}')

                        # end of this while loop
                        blackPawnAttacks = bit.popBit(blackPawnAttacks, target)

                    # generate enpassant caputes
                    if enpassant != noSquare:
                        enpassantAttacks = attacks[0][turn][start] & (ONEULL() << enpassant)

                        if enpassantAttacks:
                            targetEnpassant = bit.getLsbIndex(enpassantAttacks)
                            print(f'pawn enpassant capture {maps.FIELD_ARRAY[start]}{maps.FIELD_ARRAY[targetEnpassant]}')

                    # pop the pawn, as we have calculated everything we need
                    pieceMap = bit.popBit(pieceMap, start)
