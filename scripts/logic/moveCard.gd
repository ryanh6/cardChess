extends Sprite2D
class_name Card

enum type {
	ROOK,
	BISHOP,
	KNIGHT,
	ATTACKER,
	JUMPER
};

var cardType = type;

func _init(newType):
	cardType = newType;

static func getName(requestedType: type):
	match(requestedType):
		type.ROOK:
			return "Rook"
		type.BISHOP:
			return "BISHOP"
		type.KNIGHT:
			return "KNIGHT"
		type.ATTACKER:
			return "ATTACKER"
		type.JUMPER:
			return "JUMPER"
	return ""
	
static func getIcon(requestedType: type):
	var asset: Texture2D
	
	match(requestedType):
		type.ROOK:
			asset = preload("res://assets/rookCard.png")
		type.BISHOP:
			asset = preload("res://assets/bishopCard.png")
		type.KNIGHT:
			asset = preload("res://assets/knightCard.png")
		type.ATTACKER:
			asset = preload("res://assets/attackerCard.png")
		type.JUMPER:
			asset = preload("res://assets/jumperCard.png")
			
	return asset

func getMoves(gameBoard: Board, gamePiece: Piece):
	var forward;
	var directions = [];
	var positions = [];
	var legalMoves = [];
	
	match(cardType):
		type.ROOK:
			directions = [Vector2(0, 1), Vector2(0, -1), Vector2(1, 0), Vector2(-1, 0)];
		type.BISHOP:
			directions = [Vector2(1, 1), Vector2(1, -1), Vector2(-1, 1), Vector2(-1, -1)];
		type.KNIGHT:
			directions = [Vector2(2, 1), Vector2(2, -1), Vector2(1, 2), Vector2(-1, 2), Vector2(-2, 1), Vector2(-2, -1), Vector2(1, -2), Vector2(-1, -2)];
		type.ATTACKER:
			if (gamePiece.ownerID == 0):
				forward = -1
			else:
				forward = 1
				
			directions = [Vector2(0, forward), Vector2(-1, forward), Vector2(1, forward), Vector2(0, forward * 2)];
		type.JUMPER:
			var adjacent = [Vector2(1, 0), Vector2(-1, 1), Vector2(0, 1), Vector2(1, 1), Vector2(-1, 0), Vector2(1, -1), Vector2(0, -1), Vector2(-1, -1)];
			
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
	
func directionToPosition(gamePiece: Piece, directions: Array[Vector2i]):
	var positions = []
	
	for direction in directions:
		positions.append(gamePiece.piecePosition + direction)
		
	return positions;
