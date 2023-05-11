import cython 
import numpy as np

def intToBitArray(n):
    cdef int j = 0
    cdef unsigned long long x = n
    cdef unsigned long long i = 1

    cdef int[64] bitarray

    while(j < 64):
        if(x & i):
            bitarray[j] = 1
        else:
            bitarray[j] = 0

        i = i << 1
        j += 1

    return bitarray

def bitArrayToInt(bitarray):
    ressi = 0
    for i, bit in enumerate(bitarray):
            ressi += bit*(2**i)
    return ressi

def fullUnion(bitmaps):
    cdef unsigned long long result = 0
    for bitmap in bitmaps:
        result |= bitmap
    return result


# Returns index of LSB and a map with the LSB popped
def getLsbIndex(bitmap):
    if bitmap == 0: return -1

    cdef unsigned long long bit = 1
    cdef unsigned long long board = bitmap & bit
    cdef int index = 0
    # iterate through the bitmap until we get something else then 1 for the board
    # left shift the bit 

    while not board:
        index += 1
        bit <<=1
        board = bitmap & bit

    return index

def popBit(bitmap, index):
    cdef unsigned long long bitOnIndex = 1 << index

    if bitmap & bitOnIndex == 0:
        return bitmap
    else:
        bitmap ^= bitOnIndex
        return bitmap

def getBit(bitmap, index):
    cdef unsigned long long bitOnIndex = 1 << index
    if bitmap & bitOnIndex == 0:
        return False
    else:
        return True

def getBitIndices(bitmap):
    if bitmap == 0: return []

    indexArray = []
    cdef unsigned long long bit
    cdef unsigned long long isection 
    
    for i in range(64):
        bit = 1
        bit <<= i
        isection = bitmap & bit
        if isection:
            indexArray.append(i)
    return indexArray

def ONEULL():
    cdef unsigned long long one = 1
    return one

def ZEROULL(): 
    cdef unsigned long long zero = 0
    return zero

def setPiece(fieldIndex, bitmap):
    cdef unsigned long long pieceUnshifted = 1
    return (pieceUnshifted << fieldIndex) | bitmap 