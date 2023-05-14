import numpy as np
import src.chess.bitmethods as bit

BLACK_PAWNS_MAP = 65280
BLACK_ROOKS_MAP = 129
BLACK_KNIGHTS_MAP = 66
BLACK_BISHOPS_MAP = 36
BLACK_QUEEN_MAP = 8
BLACK_KING_MAP = 16

WHITE_PAWNS_MAP = 71776119061217280
WHITE_ROOKS_MAP = 9295429630892703744
WHITE_KNIGHTS_MAP = 4755801206503243776
WHITE_BISHOPS_MAP = 2594073385365405696
WHITE_QUEEN_MAP = 576460752303423488
WHITE_KING_MAP = 1152921504606846976

WHITE_MAPS = [
	WHITE_PAWNS_MAP,
	WHITE_ROOKS_MAP,
	WHITE_KNIGHTS_MAP,
	WHITE_BISHOPS_MAP,
	WHITE_QUEEN_MAP,
	WHITE_KING_MAP,
]

BLACK_MAPS = [
	BLACK_PAWNS_MAP,
	BLACK_ROOKS_MAP,
	BLACK_KNIGHTS_MAP,
	BLACK_BISHOPS_MAP,
	BLACK_QUEEN_MAP,
	BLACK_KING_MAP,
]

ALL_MAPS = [
	WHITE_PAWNS_MAP,
	WHITE_ROOKS_MAP,
	WHITE_KNIGHTS_MAP,
	WHITE_BISHOPS_MAP,
	WHITE_QUEEN_MAP,
	WHITE_KING_MAP,
	BLACK_PAWNS_MAP,
	BLACK_ROOKS_MAP,
	BLACK_KNIGHTS_MAP,
	BLACK_BISHOPS_MAP,
	BLACK_QUEEN_MAP,
	BLACK_KING_MAP,
]

# careful - bitmaps are reverse little endian uint represented
# meaning: array will start at 2^0, 2^1, 2^3 .... 2^63 (last array item)
# uint is the opposite way around 0.....00010 = 2

EMPTY = np.array([
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
], dtype=np.byte)

INDEX_ARRAY = np.array([
	0,  1,  2,   3,  4,  5,  6,  7,
	8,  9,  10, 11, 12, 13, 14, 15,
	16, 17, 18, 19, 20, 21, 22, 23,
	24, 25, 26, 27, 28, 29, 30, 31,
	32, 33, 34, 35, 36, 37, 38, 39,
	40, 41, 42, 43, 44, 45, 46, 47,
	48, 49, 50, 51, 52, 53, 54, 55,
	56, 57, 58, 59, 60, 61, 62, 63,
], dtype=int)

NOT_FILE_A = np.array([
	0, 1, 1, 1, 1, 1, 1, 1,
	0, 1, 1, 1, 1, 1, 1, 1,
	0, 1, 1, 1, 1, 1, 1, 1,
	0, 1, 1, 1, 1, 1, 1, 1,
	0, 1, 1, 1, 1, 1, 1, 1,
	0, 1, 1, 1, 1, 1, 1, 1,
	0, 1, 1, 1, 1, 1, 1, 1,
	0, 1, 1, 1, 1, 1, 1, 1,
], dtype=np.byte)

NOT_FILE_AB = np.array([
	0, 0, 1, 1, 1, 1, 1, 1,
	0, 0, 1, 1, 1, 1, 1, 1,
	0, 0, 1, 1, 1, 1, 1, 1,
	0, 0, 1, 1, 1, 1, 1, 1,
	0, 0, 1, 1, 1, 1, 1, 1,
	0, 0, 1, 1, 1, 1, 1, 1,
	0, 0, 1, 1, 1, 1, 1, 1,
	0, 0, 1, 1, 1, 1, 1, 1,
], dtype=np.byte)

NOT_FILE_H = np.array([
	1, 1, 1, 1, 1, 1, 1, 0,
	1, 1, 1, 1, 1, 1, 1, 0,
	1, 1, 1, 1, 1, 1, 1, 0,
	1, 1, 1, 1, 1, 1, 1, 0,
	1, 1, 1, 1, 1, 1, 1, 0,
	1, 1, 1, 1, 1, 1, 1, 0,
	1, 1, 1, 1, 1, 1, 1, 0,
	1, 1, 1, 1, 1, 1, 1, 0,
], dtype=np.byte)

NOT_FILE_GH = np.array([
	1, 1, 1, 1, 1, 1, 0, 0,
	1, 1, 1, 1, 1, 1, 0, 0,
	1, 1, 1, 1, 1, 1, 0, 0,
	1, 1, 1, 1, 1, 1, 0, 0,
	1, 1, 1, 1, 1, 1, 0, 0,
	1, 1, 1, 1, 1, 1, 0, 0,
	1, 1, 1, 1, 1, 1, 0, 0,
	1, 1, 1, 1, 1, 1, 0, 0,
], dtype=np.byte)

WHITE_PAWNS_ARRAY = np.array([
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	1, 1, 1, 1, 1, 1, 1, 1,
	0, 0, 0, 0, 0, 0, 0, 0,
], dtype=np.int64)

BLACK_PAWNS_ARRAY = np.array([
	0, 0, 0, 0, 0, 0, 0, 0,
	1, 1, 1, 1, 1, 1, 1, 1,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
], dtype=np.byte)


WHITE_ROOKS_ARRAY = np.array([
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	1, 0, 0, 0, 0, 0, 0, 1,
], dtype=np.byte)



BLACK_ROOKS_ARRAY = np.array([
	1, 0, 0, 0, 0, 0, 0, 1,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
], dtype=np.byte)


WHITE_BISHOPS_ARRAY = np.array([
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 1, 0, 0, 1, 0, 0,
], dtype=np.byte)


BLACK_BISHOPS_ARRAY = np.array([
	0, 0, 1, 0, 0, 1, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
], dtype=np.byte)


WHITE_KNIGHTS_ARRAY = np.array([
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 1, 0, 0, 0, 0, 1, 0,
], dtype=np.byte)


BLACK_KNIGHTS_ARRAY = np.array([
	0, 1, 0, 0, 0, 0, 1, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
], dtype=np.byte)


WHITE_QUEEN_ARRAY = np.array([
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 1, 0, 0, 0, 0,
], dtype=np.byte)


BLACK_QUEEN_ARRAY = np.array([
	0, 0, 0, 1, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
], dtype=np.byte)


WHITE_KING_ARRAY = np.array([
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 1, 0, 0, 0,
], dtype=np.byte)


BLACK_KING_ARRAY = np.array([
	0, 0, 0, 0, 1, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
], dtype=np.byte)


SET_BOARD_UNION = np.array([
	1, 1, 1, 1, 1, 1, 1, 1,
	1, 1, 1, 1, 1, 1, 1, 1,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 0,
	1, 1, 1, 1, 1, 1, 1, 1,
	1, 1, 1, 1, 1, 1, 1, 1,
], dtype=np.byte)


# used to bitwise and castling rights in case a piece of importance moves
CASTLING_RIGHTS = [
	 7, 15, 15, 15,  3, 15, 15, 11,
	15, 15, 15, 15, 15, 15, 15, 15,
	15, 15, 15, 15, 15, 15, 15, 15,
	15, 15, 15, 15, 15, 15, 15, 15,
	15, 15, 15, 15, 15, 15, 15, 15,
	15, 15, 15, 15, 15, 15, 15, 15,
	15, 15, 15, 15, 15, 15, 15, 15,
	13, 15, 15, 15, 12, 15, 15, 14,
]

WHITE_ARRAYS = [
	WHITE_PAWNS_ARRAY,
	WHITE_ROOKS_ARRAY,
	WHITE_KNIGHTS_ARRAY,
	WHITE_BISHOPS_ARRAY,
	WHITE_QUEEN_ARRAY,
	WHITE_KING_ARRAY,
]

BLACK_ARRAYS = [
	BLACK_PAWNS_ARRAY,
	BLACK_ROOKS_ARRAY,
	BLACK_KNIGHTS_ARRAY,
	BLACK_BISHOPS_ARRAY,
	BLACK_QUEEN_ARRAY,
	BLACK_KING_ARRAY,
]

ALL_ARRAYS = [
	WHITE_PAWNS_ARRAY,
	WHITE_ROOKS_ARRAY,
	WHITE_KNIGHTS_ARRAY,
	WHITE_BISHOPS_ARRAY,
	WHITE_QUEEN_ARRAY,
	WHITE_KING_ARRAY,
	BLACK_PAWNS_ARRAY,
	BLACK_ROOKS_ARRAY,
	BLACK_KNIGHTS_ARRAY,
	BLACK_BISHOPS_ARRAY,
	BLACK_QUEEN_ARRAY,
	BLACK_KING_ARRAY,
]

DOT_UNICODE = '\u2219'
WHITE_PAWN_UNICODE = '\u265F'
WHITE_ROOK_UNICODE = '\u265C'
WHITE_KNIGHT_UNICODE = '\u265E'
WHITE_BISHOP_UNICODE = '\u265D'
WHITE_QUEEN_UNICODE = '\u265B'
WHITE_KING_UNICODE = '\u265A'
BLACK_PAWN_UNICODE = '\u2659'
BLACK_ROOK_UNICODE = '\u2656'
BLACK_KNIGHT_UNICODE = '\u2658'
BLACK_BISHOP_UNICODE = '\u2657'
BLACK_QUEEN_UNICODE = '\u2655'
BLACK_KING_UNICODE = '\u2654'

ALL_UNICODES = [
	WHITE_PAWN_UNICODE,
	WHITE_ROOK_UNICODE,
	WHITE_KNIGHT_UNICODE,
	WHITE_BISHOP_UNICODE,
	WHITE_QUEEN_UNICODE,
	WHITE_KING_UNICODE,
	BLACK_PAWN_UNICODE,
	BLACK_ROOK_UNICODE,
	BLACK_KNIGHT_UNICODE,
	BLACK_BISHOP_UNICODE,
	BLACK_QUEEN_UNICODE,
	BLACK_KING_UNICODE 
]

WHITE_UNICODES = [
	DOT_UNICODE,
	WHITE_PAWN_UNICODE,
	WHITE_ROOK_UNICODE,
	WHITE_KNIGHT_UNICODE,
	WHITE_BISHOP_UNICODE,
	WHITE_QUEEN_UNICODE,
	WHITE_KING_UNICODE,
]

BLACK_UNICODES = [
	DOT_UNICODE,
	BLACK_PAWN_UNICODE,
	BLACK_ROOK_UNICODE,
	BLACK_KNIGHT_UNICODE,
	BLACK_BISHOP_UNICODE,
	BLACK_QUEEN_UNICODE,
	BLACK_KING_UNICODE 
]

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

ROLE_ARRAY = [
	'P',
	'R',
	'N',
	'B',
	'Q',
	'K',
	'p',
	'r',
	'n',
	'b',
	'q',
	'k',
]

# TODO: change bishop and knight scores if needed

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

COLOR_OBJ = {
	'white': 0,
	'black': 1
}

FIELD_OBJ = {
		'a8': 0, 'b8': 1, 'c8': 2, 'd8': 3, 'e8': 4, 'f8': 5, 'g8': 6, 'h8': 7,
		'a7': 8, 'b7': 9, 'c7': 10, 'd7': 11, 'e7': 12, 'f7': 13, 'g7': 14, 'h7': 15,
		'a6': 16, 'b6': 17, 'c6': 18, 'd6': 19, 'e6': 20, 'f6': 21, 'g6': 22, 'h6': 23,
		'a5': 24, 'b5': 25, 'c5': 26, 'd5': 27, 'e5': 28, 'f5': 29, 'g5': 30, 'h5': 31,
		'a4': 32, 'b4': 33, 'c4': 34, 'd4': 35, 'e4': 36, 'f4': 37, 'g4': 38, 'h4': 39,
		'a3': 40, 'b3': 41, 'c3': 42, 'd3': 43, 'e3': 44, 'f3': 45, 'g3': 46, 'h3': 47,
		'a2': 48, 'b2': 49, 'c2': 50, 'd2': 51, 'e2': 52, 'f2': 54, 'g2': 54, 'h2': 55,
		'a1': 56, 'b1': 57, 'c1': 58, 'd1': 59, 'e1': 60, 'f1': 62, 'g1': 62, 'h1': 63,
}

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

CASTLE_OBJ = {
	'K': 1,
	'Q': 2,
	'k': 4,
	'q': 8,
}

def parseCastle(castleString):
	castleInt = 0
	if castleString == '-': return castleInt

	for char in castleString:
		castleInt |= CASTLE_OBJ[char]

	return castleInt

STRING_BOARD = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'

FEN_EMPTY = '8/8/8/8/8/8/8/8 w - - '
FEN_START = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
FEN_SOME_MOVE = 'rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2'
FEN_HARD = 'r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R w KQkq - 0 1'
FEN_VERY_HARD = 'rnbqkb1r/pp1p1pPp/8/2p1pP2/1P1P4/3P3P/P1P1P3/RNBQKBNR w KQkq e6 0 1'
FEN_CMK = 'r2q1rk1/ppp2ppp/2n1bn2/2b1p3/3pP3/3P1NPP/PPP1NPB1/R1BQ1RK1 b - - 0 9'
FEN_PROBLEM = '1R6/3R4/P2PK3/4P3/4KP2/8/8/8 b - - 0 0'


def printArray(bitarray):
		numbit = np.array(bitarray)
		print(
			 f'\n'
			 f'8 {numbit[0:8]} \n'
			 f'7 {numbit[8:16]} \n'
			 f'6 {numbit[16:24]} \n'
			 f'5 {numbit[24:32]} \n'
			 f'4 {numbit[32:40]} \n'
			 f'3 {numbit[40:48]} \n'
			 f'2 {numbit[48:56]} \n'
			 f'1 {numbit[56:64]} \n'
			 f'   a b c d e f g h \n'
		)

def printChessArray(bitarray):
		numbit = np.array(bitarray)
		print(
			 f'\n'
			 f'\n'
			 f'8 {"".join(str(e) + " " for e in numbit[0:8])} \n'
			 f'7 {"".join(str(e) + " " for e in numbit[8:16])} \n'
			 f'6 {"".join(str(e) + " " for e in numbit[16:24])} \n'
			 f'5 {"".join(str(e) + " " for e in numbit[24:32])} \n'
			 f'4 {"".join(str(e) + " " for e in numbit[32:40])} \n'
			 f'3 {"".join(str(e) + " " for e in numbit[40:48])} \n'
			 f'2 {"".join(str(e) + " " for e in numbit[48:56])} \n'
			 f'1 {"".join(str(e) + " " for e in numbit[56:64])} \n'
			 f'  a b c d e f g h \n'
		)

def printMap(map):
	bitarray = bit.intToBitArray(map)
	printArray(bitarray)

# def arraysToNumberedUnion(pieceArraysList):
# 	numberedUnion = np.zeros(64, dtype=int)
# 	for index, pieceArray in enumerate(pieceArraysList):
# 		factored = np.array(pieceArray) * (index + 1)
# 		np.add(factored, numberedUnion, numberedUnion)
# 	return numberedUnion

# returns piece bitarrays from fen string 
def fenBoardToBitArrays(fenString):
	cdef unsigned long long one = 1

	P = np.zeros(64, dtype=np.uint64)
	R = np.zeros(64, dtype=np.uint64)
	N = np.zeros(64, dtype=np.uint64)
	B = np.zeros(64, dtype=np.uint64)
	Q = np.zeros(64, dtype=np.uint64)
	K = np.zeros(64, dtype=np.uint64)
	p = np.zeros(64, dtype=np.uint64)
	r = np.zeros(64, dtype=np.uint64)
	n = np.zeros(64, dtype=np.uint64)
	b = np.zeros(64, dtype=np.uint64)
	q = np.zeros(64, dtype=np.uint64)
	k = np.zeros(64, dtype=np.uint64)
	bitarrays = [P, R, N, B, Q, K, p, r, n, b, q, k]
	fieldIndex = 0

	for char in fenString:
		if char.isnumeric():
			charInt = int(char)

			if charInt < 1 or charInt > 8:
				raise ValueError('Empty field range exceeds rank size.')
				return

			fieldIndex += charInt - 1

		else:
			if char == '/': 
				continue
			elif char not in ROLE_OBJ:
				raise ValueError('Incorrect character in fen board.')
				return
			else:
				pieceIndex = ROLE_OBJ[char]
				bitarrays[pieceIndex][fieldIndex] = one
		
		fieldIndex += 1

	return bitarrays

# only god knows if the output bits are lossless
# TODO: do this properly again with bitshifting
def fenBoardToBitMaps(fenString):

	pieceArrays = fenBoardToBitArrays(fenString)
	pieceMaps = []

	for pieceArray in pieceArrays:
		pieceMap = bit.bitArrayToInt(pieceArray)
		pieceMaps.append(pieceMap)

	return pieceMaps

def fenToBoardInfo(fenString):

	fenArgs = fenString.split()
	if len(fenArgs) != 6:
		raise ValueError("FEN String is missing arguments.")

	fenBoard = fenArgs[0]
	fenTurn = fenArgs[1]
	fenCastle = fenArgs[2]
	fenEnpass = fenArgs[3]
	fenHalf = fenArgs[4]
	fenFull = fenArgs[5]

	pieceMaps = fenBoardToBitMaps(fenBoard)
	turn = 0 if fenTurn == 'w' else 1
	castling = parseCastle(fenCastle)
	enpassant = 64 if fenEnpass == '-' else FIELD_OBJ[fenEnpass]
	halfMoves = 0 if fenHalf == '-' else int(fenHalf)
	fullMoves = 0 if fenFull == '-' else int(fenFull)

	return [pieceMaps, turn, castling, enpassant, halfMoves, fullMoves]


# pieceArrays need to be sorted in PIECE_OBJ order 
def ppBitArrays(pieceArrays):
	ppArray = np.full(64, DOT_UNICODE)
	# lame O(n^2) but it's for testing only
	for i, pieceArray in enumerate(pieceArrays):
		pieceUnicode = ALL_UNICODES[i]
		for j, bit in enumerate(pieceArray):
			if bit: ppArray[j] = pieceUnicode

	printChessArray(ppArray)

# pieceMaps need to be sorted in PIECE_OBJ order
def ppBitMaps(pieceMaps):
	pieceArrays = []

	# disgusting but works 
	for pieceMap in pieceMaps:
		pieceArray = bit.intToBitArray(pieceMap)
		pieceArrays.append(pieceArray)

	ppBitArrays(pieceArrays)



	