import cython
import src.chess.bitmethods as bit
import src.chess.maps as maps

ctypedef unsigned long long ULL

cdef ULL[2][64] pawnAttacks
cdef ULL[64] knightAttacks
cdef ULL[64] kingAttacks

cdef ULL[64] rookMasks
cdef ULL[64] bishopMasks

cdef ULL[64][4096] rookAttacks
cdef ULL[64][512] bishopAttacks

cdef ULL[64] rookAttacks_otf
cdef ULL[64] bishopAttacks_otf
cdef ULL[64] queenAttacks_otf

cdef ULL NOT_FILE_H = 9187201950435737471
cdef ULL NOT_FILE_GH = 4557430888798830399
cdef ULL NOT_FILE_AB = 18229723555195321596
cdef ULL NOT_FILE_A = 18374403900871474942

cdef enum role_int:
    P, R, N, B, Q, K, p, r, n, b, q, k

cdef enum color_int:
    white, black

#stolen from the internet lol
cdef ULL[64] rook_magic_numbers = [
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

cdef ULL[64] bishop_magic_numbers = [
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

cdef int[64] rookFieldCount = [
    12, 11, 11, 11, 11, 11, 11, 12, 
    11, 10, 10, 10, 10, 10, 10, 11, 
    11, 10, 10, 10, 10, 10, 10, 11, 
    11, 10, 10, 10, 10, 10, 10, 11, 
    11, 10, 10, 10, 10, 10, 10, 11, 
    11, 10, 10, 10, 10, 10, 10, 11, 
    11, 10, 10, 10, 10, 10, 10, 11, 
    12, 11, 11, 11, 11, 11, 11, 12
]

cdef int[64] bishopFieldCount = [
    6, 5, 5, 5, 5, 5, 5, 6, 
    5, 5, 5, 5, 5, 5, 5, 5, 
    5, 5, 7, 7, 7, 7, 5, 5, 
    5, 5, 7, 9, 9, 7, 5, 5, 
    5, 5, 7, 9, 9, 7, 5, 5, 
    5, 5, 7, 7, 7, 7, 5, 5, 
    5, 5, 5, 5, 5, 5, 5, 5, 
    6, 5, 5, 5, 5, 5, 5, 6
]


cdef ULL pawnAttackMap_cy(int field, int turn):
    cdef ULL attacks = 0
    cdef ULL bitmap = 0

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

cdef ULL knightAttackMap_cy(int field):
    cdef ULL attacks = 0
    cdef ULL bitmap = 0

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

cdef ULL kingAttackMap_cy(int field):
    cdef ULL attacks = 0
    cdef ULL bitmap = 0

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


cdef ULL bishopAttackMask_cy(int field):
    cdef ULL attacks = 0
    cdef int r, f;
    cdef int fieldRank = int(field / 8)
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

cdef void initRookMasks_cy():
    for field in range(64):
        rookMasks[field] = rookAttackMask_cy(field)

cdef ULL bishopAttackMap_otf_cy(int field, ULL blockMap):
    cdef ULL attacks = 0
    cdef ULL one = 1
    cdef int r, f;
    cdef int fieldRank = int(field / 8)
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

cdef ULL rookAttackMask_cy(int field):
    cdef ULL attacks = 0
    cdef int r, f
    cdef int fieldRank = int(field / 8)
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

cdef void initBishopMasks_cy():
    for field in range(64):
        bishopMasks[field] = bishopAttackMask_cy(field)

cdef ULL rookAttackMap_otf_cy(int field, ULL blockMap):
    cdef ULL attacks = 0
    cdef int r, f
    cdef int fieldRank = int(field / 8)
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
cdef ULL queenAttackMask_cy(int field):
    return rookAttackMask_cy(field) | bishopAttackMask_cy(field)

cdef ULL queenAttackMap_otf_cy(int field, int blockMap):
    return rookAttackMap_otf_cy(field, blockMap) | bishopAttackMap_otf_cy(field, blockMap) 

# attack_maps = [pawn_attacks, rook_attacks, knight_attacks, bishop_attacks, queen_attacks, king_attacks]
# all [2][64] sized: 2 sizes (black / white), 64 attack maps for each field 
cdef void genLeaperAttacks_cy():

    for field in range(64):
        pawnAttacks[0][field] = pawnAttackMap_cy(field, 0)
        pawnAttacks[1][field] = pawnAttackMap_cy(field, 1)
        knightAttacks[field] = knightAttackMap_cy(field)
        kingAttacks[field] = kingAttackMap_cy(field)

cdef void genSliderAttacks_otf_cy(ULL blockMap):

    for field in range(64):
        rookAttacks_otf[field] = rookAttackMap_otf_cy(field, blockMap)
        bishopAttacks_otf[field] = bishopAttackMap_otf_cy(field, blockMap)
        queenAttacks_otf[field] = rookAttacks_otf[field] | bishopAttacks_otf[field]


# def allAttacks_blocked(blockMap):

#     cdef ULL[2][64] pawn_attacks
#     cdef ULL[64] knight_attacks
#     cdef ULL[64] king_attacks

#     cdef ULL[64] rook_attacks
#     cdef ULL[64] bishop_attacks
#     cdef ULL[64] queen_attacks

#     for field in range(64):
#         pawn_attacks[0][field] = pawnAttackMap_cy(field, 0)
#         pawn_attacks[1][field] = pawnAttackMap_cy(field, 1)
#         knight_attacks[field] = knightAttackMap_cy(field)
#         king_attacks[field] = kingAttackMap_cy(field)

#         rook_attacks[field] = rookAttackMap_otf_cy(field, blockMap)
#         bishop_attacks[field] = bishopAttackMap_otf_cy(field, blockMap)
#         queen_attacks[field] = rook_attacks[field] | bishop_attacks[field]
        

#     attack_maps = [pawn_attacks, rook_attacks, knight_attacks, bishop_attacks, queen_attacks, king_attacks]
#     return attack_maps

cdef ULL genBlockMap_cy(int index, int bitCount, ULL attackMap):
    cdef ULL permutationMap = 0

    for i in range(bitCount):

        field = bit.getLsbIndex(attackMap)
        attackMap = bit.popBit(attackMap, field)

        if index & (bit.ONEULL() << i):
            permutationMap |= (bit.ONEULL() << field)

    return permutationMap 


cdef void genSliderAttackMaps_cy():

    cdef ULL rookBitCount
    cdef ULL bishopBitCount

    cdef ULL rookFieldIndices
    cdef ULL bishopFieldIndices

    cdef ULL rookAttackPermutations
    cdef ULL bishopAttackPermutations
    cdef ULL rook_magicIndex
    cdef ULL rookLeft
    cdef ULL rookRight
    
    cdef ULL bishop_magicIndex
    cdef ULL bishopLeft
    cdef ULL bishopRight

    cdef ULL sixtyFour = 64

    initRookMasks_cy()
    initBishopMasks_cy()

    for field in range(64):

        rookBitCount = len(bit.getBitIndices(rookMasks[field]))
        bishopBitCount = len(bit.getBitIndices(bishopMasks[field]))

        rookFieldIndices = (bit.ONEULL() << rookBitCount)
        bishopFieldIndices = (bit.ONEULL() << bishopBitCount)

        r = 0
        b = 0

        while r < rookFieldIndices:
            rookAttackPermutations = genBlockMap_cy(r, rookBitCount, rookMasks[field])

            # if field == 56:
            #     maps.printMap(rookAttackPermutations)

            rookLeft = rookAttackPermutations * rook_magic_numbers[field]
            rookRight = sixtyFour - rookFieldCount[field]

            rook_magicIndex = rookLeft >> rookRight 

            rookAttacks[field][rook_magicIndex] = rookAttackMap_otf_cy(field, rookAttackPermutations)
            r += 1

        while b < bishopFieldIndices:
            bishopAttackPermutations = genBlockMap_cy(b, bishopBitCount, bishopMasks[field])
            bishopLeft = bishopAttackPermutations * bishop_magic_numbers[field]
            bishopRight = sixtyFour - bishopFieldCount[field]

            bishop_magicIndex = bishopLeft >> bishopRight
            bishopAttacks[field][bishop_magicIndex] = bishopAttackMap_otf_cy(field, bishopAttackPermutations)
            b += 1

        # rookBitCount = 0
        # bishopBitCount = 0
        # rookFieldIndices = 0
        # bishopFieldIndices = 0

cdef ULL getRookAttackMap_cy(int field, ULL blockMap):
    cdef ULL attackFields
    cdef ULL magicOneDIndex
    cdef ULL magicIndex

    if isinstance(blockMap, list):
        print("getRookAttackMap_cy: TypeError - received array instead of bitmap")

    attackFields = blockMap & rookMasks[field]
    magicOneDIndex = (attackFields * rook_magic_numbers[field]) >> (64 - rookFieldCount[field])
    magicIndex = magicOneDIndex % 4096

    return rookAttacks[field][magicIndex]

cdef ULL getBishopAttackMap_cy(int field, ULL blockMap):
    cdef ULL attackFields
    cdef ULL magicOneDIndex
    cdef ULL magicIndex

    if isinstance(blockMap, list):
        print("getBishopAttackMap_cy: TypeError - received array instead of bitmap")

    attackFields = blockMap & bishopMasks[field]
    magicOneDIndex = (attackFields * bishop_magic_numbers[field]) >> (64 - bishopFieldCount[field])
    magicIndex = magicOneDIndex % 512

    return bishopAttacks[field][magicIndex]

cdef ULL getQueenAttackMap_cy(int field, ULL blockMap):
    return getRookAttackMap_cy(field, blockMap) | getBishopAttackMap_cy(field, blockMap)

cdef ULL getPieceAttackMap_cy(int piece, int field, ULL blockMap):
        if piece == P: return getPawnAttackMap(0, field)
        elif piece == p: return getPawnAttackMap(1, field)
        elif piece == R or piece == r: return getRookAttackMap_cy(field, blockMap)
        elif piece == N or piece == n: return getKnightAttackMap(field)
        elif piece == B or piece == b: return getBishopAttackMap_cy(field, blockMap)
        elif piece == Q or piece == q: return getQueenAttackMap_cy(field, blockMap)
        elif piece == K or piece == k: return getKingAttackMap(field)
        else: return 0

cdef ULL getPieceAttackMap_otf_cy(int piece, int field):
        if piece == P: return pawnAttacks[0][field]
        elif piece == p: return pawnAttacks[1][field]
        elif piece == R or piece == r: return rookAttacks_otf[field]
        elif piece == N or piece == n: return knightAttacks[field]
        elif piece == B or piece == b: return bishopAttacks_otf[field]
        elif piece == Q or piece == q: return queenAttacks_otf[field]
        elif piece == K or piece == k: return kingAttacks[field]
        else: return 0

cdef getAllPieceAttackMaps_otf_cy(int piece):
        if piece == P: return pawnAttacks[0]
        elif piece == p: return pawnAttacks[1]
        elif piece == R or piece == r: return rookAttacks_otf
        elif piece == N or piece == n: return knightAttacks
        elif piece == B or piece == b: return bishopAttacks_otf
        elif piece == Q or piece == q: return queenAttacks_otf
        elif piece == K or piece == k: return kingAttacks
        else: return []

cdef void updateAttackMaps_otf_cy(ULL blockMap):
    genSliderAttacks_otf_cy(blockMap)

cdef void genAttackMaps_otf_cy(ULL blockMap):
    genLeaperAttacks_cy()
    genSliderAttacks_otf_cy(blockMap)

cdef void genAttackMaps_cy():
    genLeaperAttacks_cy()
    genSliderAttackMaps_cy()

##################### Proxies with outside access #######################

# Magic
def getPawnAttackMap(color, field):
    return pawnAttacks[color][field]

def getRookAttackMap(field, blockMap):
    return getRookAttackMap_cy(field, blockMap)

def getKnightAttackMap(field):
    return knightAttacks[field]

def getBishopAttackMap(field, blockMap):
    return getBishopAttackMap_cy(field, blockMap)

def getQueenAttackMap(field, blockMap):
    return getQueenAttackMap_cy(field, blockMap)

def getKingAttackMap(field):
    return kingAttacks[field]

def getPieceAttackMap(piece, field, blockMap):
    return getPieceAttackMap_cy(piece, field, blockMap)

def getAllPawnAttackMaps(color):
    return pawnAttacks[color]

def getAllKnightAttackMaps():
    return knightAttacks

def getAllKingAttackMaps():
    return kingAttacks

def getAllRookAttackMaps():
    return rookAttacks

def getAllBishopAttackMaps():
    return bishopAttacks

def genAttackMaps():
    genAttackMaps_cy()

# On the fly

def getRookAttackMap_otf(field):
    return rookAttacks_otf[field]

def getBishopAttackMap_otf(field):
    return bishopAttacks_otf[field]

def getQueenAttackMap_otf(field):
    return queenAttacks_otf[field]

def getPieceAttackMap_otf(piece, field):
    return getPieceAttackMap_otf_cy(piece, field)

def getAllRookAttackMaps_otf():
    return rookAttacks_otf

def getAllBishopAttackMaps_otf():
    return bishopAttacks_otf

def getAllQueenAttackMaps_otf():
    return queenAttacks_otf

def getAllPieceAttackMaps_otf(int piece):
    return getAllPieceAttackMaps_otf_cy(piece)

def updateAttackMaps_otf(blockMap):
    updateAttackMaps_otf_cy(blockMap)

def genAttackMaps_otf(blockMap):
    genAttackMaps_otf_cy(blockMap)

###################### Generate ###############
genAttackMaps_cy()
print("\n Attacks initialized!")
# genAttackMaps_otf_cy(maps.START_UNION_MAP)