import cython
import src.chess.bitmethods as bit

cdef unsigned long long NOT_FILE_H = 9187201950435737471
cdef unsigned long long NOT_FILE_GH = 4557430888798830399
cdef unsigned long long NOT_FILE_AB = 18229723555195321596
cdef unsigned long long NOT_FILE_A = 18374403900871474942

def singlePawnAttacks(fieldIndex, turn):
    cdef unsigned long long attacks = 0
    cdef unsigned long long bitmap = 0

    bitmap = bit.setBit(bitmap, fieldIndex)

    if turn == 0:
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

    bitmap = bit.setBit(bitmap, fieldIndex)

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

    bitmap = bit.setBit(bitmap, fieldIndex)

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
        attacks |= (bit.ONEULL() << (r * 8 + f))
        r += 1
        f += 1

    r = fieldRank - 1
    f = fieldFile + 1

    while r >= 1 and f <= 6:
        attacks |= (bit.ONEULL() << (r * 8 + f))
        r -= 1
        f += 1

    r = fieldRank + 1
    f = fieldFile - 1

    while r <= 6 and f >= 1:
        attacks |= (bit.ONEULL() << (r * 8 + f))
        r += 1
        f -= 1

    r = fieldRank - 1
    f = fieldFile - 1

    while r >= 1 and f >= 1:
        attacks |= (bit.ONEULL() << (r * 8 + f))
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
        attacks |= (bit.ONEULL() << (r * 8 + f))
        if ((bit.ONEULL() << (r * 8 + f)) & blockMap): break
        r += 1
        f += 1

    r = fieldRank - 1
    f = fieldFile + 1

    while r >= 0 and f <= 7:
        attacks |= (bit.ONEULL() << (r * 8 + f))
        if ((bit.ONEULL() << (r * 8 + f)) & blockMap): break
        r -= 1
        f += 1

    r = fieldRank + 1
    f = fieldFile - 1

    while r <= 7 and f >= 0:
        attacks |= (bit.ONEULL() << (r * 8 + f))
        if ((bit.ONEULL() << (r * 8 + f)) & blockMap): break
        r += 1
        f -= 1

    r = fieldRank - 1
    f = fieldFile - 1

    while r >= 0 and f >= 0:
        attacks |= (bit.ONEULL() << (r * 8 + f))
        if ((bit.ONEULL() << (r * 8 + f)) & blockMap): break
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
        attacks |= (bit.ONEULL() << (r * 8 + fieldFile))
        r += 1

    r = fieldRank - 1
    while r >= 1:
        attacks |= (bit.ONEULL() << (r * 8 + fieldFile))
        r -= 1

    f = fieldFile + 1
    while f <= 6:
        attacks |= (bit.ONEULL() << (fieldRank * 8 + f))
        f += 1

    f = fieldFile - 1
    while f >= 1:
        attacks |= (bit.ONEULL() << (fieldRank * 8 + f))
        f -= 1

    return attacks

def singleRookAttacks_blocked(fieldIndex, blockMap):
    cdef unsigned long long attacks = 0
    cdef int r, f
    cdef int fieldRank = fieldIndex / 8
    cdef int fieldFile = fieldIndex % 8

    r = fieldRank + 1
    while r <= 7:
        attacks |= (bit.ONEULL() << (r * 8 + fieldFile))
        if ((bit.ONEULL() << (r * 8 + fieldFile)) & blockMap): break
        r += 1

    r = fieldRank - 1
    while r >= 0:
        attacks |= (bit.ONEULL() << (r * 8 + fieldFile))
        if ((bit.ONEULL() << (r * 8 + fieldFile)) & blockMap): break
        r -= 1

    f = fieldFile + 1
    while f <= 7:
        attacks |= (bit.ONEULL() << (fieldRank * 8 + f))
        if ((bit.ONEULL() << (fieldRank * 8 + f)) & blockMap): break
        f += 1

    f = fieldFile - 1
    while f >= 0:
        attacks |= (bit.ONEULL() << (fieldRank * 8 + f))
        if ((bit.ONEULL() << (fieldRank * 8 + f)) & blockMap): break
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
        pawn_attacks[0][field] = singlePawnAttacks(field, 0)
        pawn_attacks[1][field] = singlePawnAttacks(field, 1)
        knight_attacks[field] = singleKnightAttacks(field)
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

def allAttacks_blocked(blockMap):

    cdef unsigned long long[2][64] pawn_attacks
    cdef unsigned long long[64] knight_attacks
    cdef unsigned long long[64] king_attacks

    cdef unsigned long long[64] rook_attacks
    cdef unsigned long long[64] bishop_attacks
    cdef unsigned long long[64] queen_attacks

    for field in range(64):
        pawn_attacks[0][field] = singlePawnAttacks(field, 0)
        pawn_attacks[1][field] = singlePawnAttacks(field, 1)
        knight_attacks[field] = singleKnightAttacks(field)
        king_attacks[field] = singleKingAttacks(field)

        rook_attacks[field] = singleRookAttacks_blocked(field, blockMap)
        bishop_attacks[field] = singleBishopAttacks_blocked(field, blockMap)
        queen_attacks[field] = rook_attacks[field] | bishop_attacks[field]
        

    attack_maps = [pawn_attacks, rook_attacks, knight_attacks, bishop_attacks, queen_attacks, king_attacks]
    return attack_maps