import cython

def encode(start, target, piece, promoted, capture, doublePush, enpassant, castling):
    cdef unsigned long long encoded = start|(target << 6)|(piece<< 12)|(promoted<< 16)|(capture<<20)|(doublePush<<21)|(enpassant<<22)|(castling<<23)
    return encoded

def getStart(unsigned long long encMove):
    return encMove & 63

def getTarget(unsigned long long encMove):
    return (encMove & 4032) >> 6 

def getPiece(unsigned long long encMove):
    return (encMove & 61440) >> 12 

def getPromoted(unsigned long long encMove):
    return (encMove & 983040) >> 16 

def getCapture(unsigned long long encMove):
    return encMove & 1048576

def getDoublePush(unsigned long long encMove):
    return encMove & 2097152

def getEnpassant(unsigned long long encMove):
    return encMove & 4194304

def getCastling(unsigned long long encMove):
    return encMove & 8388608

def decode(unsigned long long encMove):
    return getStart(encMove), getTarget(encMove), getPiece(encMove), getPromoted(encMove), getCapture(encMove), getDoublePush(encMove), getEnpassant(encMove), getCastling(encMove) 
