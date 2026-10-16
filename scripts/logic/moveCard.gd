extends RefCounted
class_name Card

enum type {
	ROOK,
	BISHOP,
	KNIGHT,
	ATTACKER,
	JUMPER
};

var cardType = type;

func _init(newType: type = type.ROOK) -> void:
	cardType = newType;

static func getName(requestedType: type) -> String:
	match(requestedType):
		type.ROOK:
			return "ROOK"
		type.BISHOP:
			return "BISHOP"
		type.KNIGHT:
			return "KNIGHT"
		type.ATTACKER:
			return "ATTACKER"
		type.JUMPER:
			return "JUMPER"
	return ""
	
static func getIcon(requestedType: type) -> Texture2D:	
	match(requestedType):
		type.ROOK:
			return preload("res://assets/rookCard.png")
		type.BISHOP:
			return preload("res://assets/bishopCard.png")
		type.KNIGHT:
			return preload("res://assets/knightCard.png")
		type.ATTACKER:
			return preload("res://assets/attackerCard.png")
		type.JUMPER:
			return preload("res://assets/jumperCard.png")
			
	return null

func getMoves(gameBoard: Board, gamePiece: Piece) -> Array[Vector2i]:
	var forward: int;
	var directions: Array[Vector2i] = [];
	var positions: Array[Vector2i] = [];
	var legalMoves: Array[Vector2i] = [];
	
	match(cardType):
		type.ROOK:
			directions = [Vector2i(0, 1), Vector2i(0, -1), Vector2i(1, 0), Vector2i(-1, 0)];
		type.BISHOP:
			directions = [Vector2i(1, 1), Vector2i(1, -1), Vector2i(-1, 1), Vector2i(-1, -1)];
		type.KNIGHT:
			directions = [Vector2i(2, 1), Vector2i(2, -1), Vector2i(1, 2), Vector2i(-1, 2), Vector2i(-2, 1), Vector2i(-2, -1), Vector2i(1, -2), Vector2i(-1, -2)];
		type.ATTACKER:
			if (gamePiece.ownerID == 0):
				forward = -1
			else:
				forward = 1
				
			directions = [Vector2i(0, forward), Vector2i(-1, forward), Vector2i(1, forward), Vector2i(0, forward * 2)];
		type.JUMPER:
			var adjacent = [Vector2i(1, 0), Vector2i(-1, 1), Vector2i(0, 1), Vector2i(1, 1), Vector2i(-1, 0), Vector2i(1, -1), Vector2i(0, -1), Vector2i(-1, -1)];
			
			for locations in adjacent:
				if gameBoard.pieceAt(gamePiece.piecePosition + locations) != null:
					directions.append(locations * 2)
			
	positions = directionToPosition(gamePiece, directions)
	
	for cell in positions:
		if not gameBoard.isValidPosition(cell):
			continue
			
		var currentPiece: Piece = gameBoard.pieceAt(cell);
		if currentPiece == null or currentPiece.ownerID != gamePiece.ownerID:
			legalMoves.append(cell)
	
	return legalMoves;
	
func directionToPosition(gamePiece: Piece, directions: Array[Vector2i]) -> Array[Vector2i]:
	var positions: Array[Vector2i] = []
	
	for direction in directions:
		positions.append(gamePiece.piecePosition + direction)
		
	return positions;
