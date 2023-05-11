import cython

def encode(start, target, piece, promoted, capture, doublePush, enpassant, castling):
    cdef unsigned long long encoded = start|(target << 6)|(piece<< 12)|(promoted<< 16)|(capture<<20)|(doublePush<<21)|(enpassant<<22)|(castling<<23)
    return encoded

def getStart(encMove):
    return encMove & 63

def getTarget(encMove):
    return (encMove & 4032) >> 6 

def getPiece(encMove):
    return (encMove & 61440) >> 12 

def getPromoted(encMove):
    return (encMove & 983040) >> 16 

def getCapture(encMove):
    return encMove & 1048576

def getDoublePush(encMove):
    return encMove & 2097152

def getEnpassant(encMove):
    return encMove & 4194304

def getCastling(encMove):
    return encMove & 8388608
