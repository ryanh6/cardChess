extends Sprite2D
class_name Board

const PLAYERPIECES: int = 5;
var boardSize: int = 5;
var allPieces: Array[Piece] = []

func setSize(newSize: int):
	if not [5, 7, 9].has(newSize):
		return
	boardSize = newSize

func resetBoard():
	allPieces.clear()
	var firstColumn: int = (boardSize - PLAYERPIECES) / 2
	
	for offset in PLAYERPIECES:
		var column: int = firstColumn + offset
		
		allPieces.append(Piece.new(0, Vector2i(column, boardSize - 1)))
		allPieces.append(Piece.new(1, Vector2i(column, 0)))

func isValidPosition(currentPosition: Vector2i):
	return currentPosition.x >= 0 and currentPosition.x < boardSize and currentPosition.y >= 0 and currentPosition.y < boardSize

func pieceAt(currentPosition: Vector2i):
	for piece in allPieces:
		if piece.piecePosition == currentPosition:
			return piece
	
	return null

func isEmpty(currentPosition: Vector2i):
	return pieceAt(currentPosition) == null

func isEnemy(playerID: int, currentPosition: Vector2i):
	var foundPiece = pieceAt(currentPosition)
	
	if (foundPiece != null):
		if (foundPiece.ownerID != playerID):
			return true
	
	return false

func countTeamPieces(playerID: int):
	var count: int = 0
	
	for piece in allPieces:
		if piece.ownerID == playerID:
			count += 1
	
	return count

func movePiece(fromLocation: Vector2i, toLocation: Vector2i):
	var movingPiece: Piece = pieceAt(fromLocation)
	var capturedPiece: Piece = pieceAt(toLocation)
	
	if capturedPiece != null:
		allPieces.erase(capturedPiece)
	
	movingPiece.position = toLocation
	return capturedPiece
