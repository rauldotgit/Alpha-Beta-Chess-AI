import cython
import src.chess.bitmethods as bit
import src.chess.maps as maps


cdef unsigned long long[2][64] pawnAttacks
cdef unsigned long long[64] knightAttacks
cdef unsigned long long[64] kingAttacks

cdef unsigned long long[64] rookMasks
cdef unsigned long long[64] bishopMasks

cdef unsigned long long[64][4096] rookAttacks_magic
cdef unsigned long long[64][512] bishopAttacks_magic

cdef unsigned long long[64] rookAttacks_otf
cdef unsigned long long[64] bishopAttacks_otf
cdef unsigned long long[64] queenAttacks_otf

cdef unsigned long long NOT_FILE_H = 9187201950435737471
cdef unsigned long long NOT_FILE_GH = 4557430888798830399
cdef unsigned long long NOT_FILE_AB = 18229723555195321596
cdef unsigned long long NOT_FILE_A = 18374403900871474942

cdef enum role_int:
    P, R, N, B, Q, K, p, r, n, b, q, k

cdef enum color_int:
    white, black

#stolen from the internet lol
cdef unsigned long long[64] rook_magic_numbers = [
    0x8a80104000800020,
    0x140002000100040,
    0x2801880a0017001,
    0x100081001000420,
    0x200020010080420,
    0x3001c0002010008,
    0x8480008002000100,
    0x2080088004402900,
    0x800098204000,
    0x2024401000200040,
    0x100802000801000,
    0x120800800801000,
    0x208808088000400,
    0x2802200800400,
    0x2200800100020080,
    0x801000060821100,
    0x80044006422000,
    0x100808020004000,
    0x12108a0010204200,
    0x140848010000802,
    0x481828014002800,
    0x8094004002004100,
    0x4010040010010802,
    0x20008806104,
    0x100400080208000,
    0x2040002120081000,
    0x21200680100081,
    0x20100080080080,
    0x2000a00200410,
    0x20080800400,
    0x80088400100102,
    0x80004600042881,
    0x4040008040800020,
    0x440003000200801,
    0x4200011004500,
    0x188020010100100,
    0x14800401802800,
    0x2080040080800200,
    0x124080204001001,
    0x200046502000484,
    0x480400080088020,
    0x1000422010034000,
    0x30200100110040,
    0x100021010009,
    0x2002080100110004,
    0x202008004008002,
    0x20020004010100,
    0x2048440040820001,
    0x101002200408200,
    0x40802000401080,
    0x4008142004410100,
    0x2060820c0120200,
    0x1001004080100,
    0x20c020080040080,
    0x2935610830022400,
    0x44440041009200,
    0x280001040802101,
    0x2100190040002085,
    0x80c0084100102001,
    0x4024081001000421,
    0x20030a0244872,
    0x12001008414402,
    0x2006104900a0804,
    0x1004081002402
]

cdef unsigned long long[64] bishop_magic_numbers = [
    0x40040844404084,
    0x2004208a004208,
    0x10190041080202,
    0x108060845042010,
    0x581104180800210,
    0x2112080446200010,
    0x1080820820060210,
    0x3c0808410220200,
    0x4050404440404,
    0x21001420088,
    0x24d0080801082102,
    0x1020a0a020400,
    0x40308200402,
    0x4011002100800,
    0x401484104104005,
    0x801010402020200,
    0x400210c3880100,
    0x404022024108200,
    0x810018200204102,
    0x4002801a02003,
    0x85040820080400,
    0x810102c808880400,
    0xe900410884800,
    0x8002020480840102,
    0x220200865090201,
    0x2010100a02021202,
    0x152048408022401,
    0x20080002081110,
    0x4001001021004000,
    0x800040400a011002,
    0xe4004081011002,
    0x1c004001012080,
    0x8004200962a00220,
    0x8422100208500202,
    0x2000402200300c08,
    0x8646020080080080,
    0x80020a0200100808,
    0x2010004880111000,
    0x623000a080011400,
    0x42008c0340209202,
    0x209188240001000,
    0x400408a884001800,
    0x110400a6080400,
    0x1840060a44020800,
    0x90080104000041,
    0x201011000808101,
    0x1a2208080504f080,
    0x8012020600211212,
    0x500861011240000,
    0x180806108200800,
    0x4000020e01040044,
    0x300000261044000a,
    0x802241102020002,
    0x20906061210001,
    0x5a84841004010310,
    0x4010801011c04,
    0xa010109502200,
    0x4a02012000,
    0x500201010098b028,
    0x8040002811040900,
    0x28000010020204,
    0x6000020202d0240,
    0x8918844842082200,
    0x4010011029020020
]

cdef int[64] rookAttackfieldCount = [
    12, 11, 11, 11, 11, 11, 11, 12, 
    11, 10, 10, 10, 10, 10, 10, 11, 
    11, 10, 10, 10, 10, 10, 10, 11, 
    11, 10, 10, 10, 10, 10, 10, 11, 
    11, 10, 10, 10, 10, 10, 10, 11, 
    11, 10, 10, 10, 10, 10, 10, 11, 
    11, 10, 10, 10, 10, 10, 10, 11, 
    12, 11, 11, 11, 11, 11, 11, 12
]

cdef int[64] bishopAttackfieldCount = [
    6, 5, 5, 5, 5, 5, 5, 6, 
    5, 5, 5, 5, 5, 5, 5, 5, 
    5, 5, 7, 7, 7, 7, 5, 5, 
    5, 5, 7, 9, 9, 7, 5, 5, 
    5, 5, 7, 9, 9, 7, 5, 5, 
    5, 5, 7, 7, 7, 7, 5, 5, 
    5, 5, 5, 5, 5, 5, 5, 5, 
    6, 5, 5, 5, 5, 5, 5, 6
]


def singlePawnAttacks(field, turn):
    cdef unsigned long long attacks = 0
    cdef unsigned long long bitmap = 0

    bitmap = bit.setBit(bitmap, field)

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

def singleKnightAttacks(field):
    cdef unsigned long long attacks = 0
    cdef unsigned long long bitmap = 0

    bitmap = bit.setBit(bitmap, field)

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

def singleKingAttacks(field):
    cdef unsigned long long attacks = 0
    cdef unsigned long long bitmap = 0

    bitmap = bit.setBit(bitmap, field)

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


def singleBishopMask(field):
    cdef unsigned long long attacks = 0
    cdef int r, f;
    cdef int fieldRank = field / 8
    cdef int fieldFile = field % 8

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

def initializeRookMasks():
    for field in range(64):
        rookMasks[field] = singleRookMask(field)

def singleBishopAttacks_otf(field, blockMap):
    cdef unsigned long long attacks = 0
    cdef unsigned long long one = 1
    cdef int r, f;
    cdef int fieldRank = field / 8
    cdef int fieldFile = field % 8

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

def singleRookMask(field):
    cdef unsigned long long attacks = 0
    cdef int r, f
    cdef int fieldRank = field / 8
    cdef int fieldFile = field % 8

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

def initializeBishopMasks():
    for field in range(64):
        bishopMasks[field] = singleBishopMask(field)


def singleRookAttacks_otf(field, blockMap):
    cdef unsigned long long attacks = 0
    cdef int r, f
    cdef int fieldRank = field / 8
    cdef int fieldFile = field % 8

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
def singleQueenMask(field):
    return singleRookMask(field) | singleBishopMask(field)

def singleQueenAttacks_otf(field, blockMap):
    return singleRookAttacks_otf(field, blockMap) | singleBishopAttacks_otf(field, blockMap) 

# attack_maps = [pawn_attacks, rook_attacks, knight_attacks, bishop_attacks, queen_attacks, king_attacks]
# all [2][64] sized: 2 sizes (black / white), 64 attack maps for each field 
def generateLeaperAttacks():

    for field in range(64):
        pawnAttacks[0][field] = singlePawnAttacks(field, 0)
        pawnAttacks[1][field] = singlePawnAttacks(field, 1)
        knightAttacks[field] = singleKnightAttacks(field)
        kingAttacks[field] = singleKingAttacks(field)

def generateSliderAttacks_otf(blockMap):

    for field in range(64):
        rookAttacks_otf[field] = singleRookAttacks_otf(field, blockMap)
        bishopAttacks_otf[field] = singleBishopAttacks_otf(field, blockMap)
        queenAttacks_otf[field] = rookAttacks_otf[field] | bishopAttacks_otf[field]


# def allAttacks_blocked(blockMap):

#     cdef unsigned long long[2][64] pawn_attacks
#     cdef unsigned long long[64] knight_attacks
#     cdef unsigned long long[64] king_attacks

#     cdef unsigned long long[64] rook_attacks
#     cdef unsigned long long[64] bishop_attacks
#     cdef unsigned long long[64] queen_attacks

#     for field in range(64):
#         pawn_attacks[0][field] = singlePawnAttacks(field, 0)
#         pawn_attacks[1][field] = singlePawnAttacks(field, 1)
#         knight_attacks[field] = singleKnightAttacks(field)
#         king_attacks[field] = singleKingAttacks(field)

#         rook_attacks[field] = singleRookAttacks_otf(field, blockMap)
#         bishop_attacks[field] = singleBishopAttacks_otf(field, blockMap)
#         queen_attacks[field] = rook_attacks[field] | bishop_attacks[field]
        

#     attack_maps = [pawn_attacks, rook_attacks, knight_attacks, bishop_attacks, queen_attacks, king_attacks]
#     return attack_maps

def attackPermutations(index, bitCount, attackMap):
    cdef unsigned long long permutationMap = 0

    for i in range(bitCount):

        field = bit.getLsbIndex(attackMap)
        attackMap = bit.popBit(attackMap, field)

        if index & (bit.ONEULL() << i):
            permutationMap |= (bit.ONEULL() << field)

    return permutationMap 


def generateSliderAttacks_magic():

    cdef unsigned long long rookBitCount
    cdef unsigned long long bishopBitCount

    cdef unsigned long long rookFieldIndices
    cdef unsigned long long bishopFieldIndices

    cdef unsigned long long rookAttackPermutations
    cdef unsigned long long bishopAttackPermutations
    cdef unsigned long long rook_magicIndex
    cdef unsigned long long rookLeft
    cdef unsigned long long rookRight
    
    cdef unsigned long long bishop_magicIndex
    cdef unsigned long long bishopLeft
    cdef unsigned long long bishopRight

    cdef unsigned long long sixtyFour = 64

    initializeRookMasks()
    initializeBishopMasks()

    for field in range(64):

        rookBitCount = len(bit.getBitIndices(rookMasks[field]))
        bishopBitCount = len(bit.getBitIndices(bishopMasks[field]))

        rookFieldIndices = (bit.ONEULL() << rookBitCount)
        bishopFieldIndices = (bit.ONEULL() << bishopBitCount)

        r = 0
        b = 0

        while r < rookFieldIndices:
            rookAttackPermutations = attackPermutations(r, rookBitCount, rookMasks[field])

            # if field == 56:
            #     maps.printMap(rookAttackPermutations)

            rookLeft = rookAttackPermutations * rook_magic_numbers[field]
            rookRight = sixtyFour - rookAttackfieldCount[field]

            rook_magicIndex = rookLeft >> rookRight 

            rookAttacks_magic[field][rook_magicIndex] = singleRookAttacks_otf(field, rookAttackPermutations)
            r += 1

        while b < bishopFieldIndices:
            bishopAttackPermutations = attackPermutations(b, bishopBitCount, bishopMasks[field])
            bishopLeft = bishopAttackPermutations * bishop_magic_numbers[field]
            bishopRight = sixtyFour - bishopAttackfieldCount[field]

            bishop_magicIndex = bishopLeft >> bishopRight
            bishopAttacks_magic[field][bishop_magicIndex] = singleBishopAttacks_otf(field, bishopAttackPermutations)
            b += 1

        rookBitCount = 0
        bishopBitCount = 0
        rookFieldIndices = 0
        bishopFieldIndices = 0


def getAllPawnAttacks(color):
    return pawnAttacks[color]

def getAllKnightAttacks():
    return knightAttacks

def getAllKingAttacks():
    return kingAttacks

def getAllRookAttacks_otf():
    return rookAttacks_otf

def getAllBishopAttacks_otf():
    return bishopAttacks_otf

def getAllQueenAttacks_otf():
    return queenAttacks_otf

def getAllRookAttacks_magic():
    return rookAttacks_magic

def getAllBishopAttacks_magic():
    return bishopAttacks_magic

def getPawnAttack(color, field):
    return pawnAttacks[color][field]

def getKnightAttack(field):
    return knightAttacks[field]

def getKingAttack(field):
    return kingAttacks[field]

# make sure to have the otf ones updated 
def getRookAttack_otf(field):
    return rookAttacks_otf[field]

def getBishopAttack_otf(field):
    return bishopAttacks_otf[field]

def getQueenAttack_otf(field):
    return queenAttacks_otf[field]

def getRookAttack_magic(field, unsigned long long blockMap):
    cdef unsigned long long attackFields
    cdef unsigned long long magicOneDIndex
    cdef unsigned long long magicIndex

    if isinstance(blockMap, list):
        print("getRookAttack_magic: TypeError - received array instead of bitmap")

    attackFields = blockMap & rookMasks[field]
    magicOneDIndex = (attackFields * rook_magic_numbers[field]) >> (64 - rookAttackfieldCount[field])
    magicIndex = magicOneDIndex % 4096

    return rookAttacks_magic[field][magicIndex]

def getBishopAttack_magic(field, unsigned long long blockMap):
    cdef unsigned long long attackFields
    cdef unsigned long long magicOneDIndex
    cdef unsigned long long magicIndex

    if isinstance(blockMap, list):
        print("getRookAttack_magic: TypeError - received array instead of bitmap")

    attackFields = blockMap & bishopMasks[field]
    magicOneDIndex = (attackFields * bishop_magic_numbers[field]) >> (64 - bishopAttackfieldCount[field])
    magicIndex = magicOneDIndex % 512

    return bishopAttacks_magic[field][magicIndex]

def getQueenAttack_magic(field, blockMap):
    return getRookAttack_magic(field, blockMap) | getBishopAttack_magic(field, blockMap)

def getPieceAttack_magic(piece, field, blockMap):
        if piece == P: return getPawnAttack(0, field)
        elif piece == p: return getPawnAttack(1, field)
        elif piece == R or piece == r: return getRookAttack_magic(field, blockMap)
        elif piece == N or piece == n: return getKnightAttack(field)
        elif piece == B or piece == b: return getBishopAttack_magic(field, blockMap)
        elif piece == Q or piece == q: return getQueenAttack_magic(field, blockMap)
        elif piece == K or piece == k: return getKingAttack(field)
        else: return None

def getPieceAttacks_otf(piece, field):
        if piece == P: return pawnAttacks[0][field]
        elif piece == p: return pawnAttacks[1][field]
        elif piece == R or piece == r: return rookAttacks_otf[field]
        elif piece == N or piece == n: return knightAttacks[field]
        elif piece == B or piece == b: return bishopAttacks_otf[field]
        elif piece == Q or piece == q: return queenAttacks_otf[field]
        elif piece == K or piece == k: return kingAttacks[field]
        else: return None

def getAllPieceAttacks_otf(piece):
        if piece == P: return pawnAttacks[0]
        elif piece == p: return pawnAttacks[1]
        elif piece == R or piece == r: return rookAttacks_otf
        elif piece == N or piece == n: return knightAttacks
        elif piece == B or piece == b: return bishopAttacks_otf
        elif piece == Q or piece == q: return queenAttacks_otf
        elif piece == K or piece == k: return kingAttacks
        else: return None

def updateAttackMaps_otf(blockMap):
    generateSliderAttacks_otf(blockMap)

def generateAttackMaps_otf(blockMap):
    generateLeaperAttacks()
    generateSliderAttacks_otf(blockMap)

def generateAttackMaps_magic():
    generateLeaperAttacks()
    generateSliderAttacks_magic()

###################### Generate ###############
generateAttackMaps_magic()
print("\n Attacks initialized!")
# generateAttackMaps_otf(maps.START_UNION_MAP)