extends Sprite2D
class_name Piece

var ownerID: int;
var piecePosition: Vector2i;

func _init(newOwnerID: int, newPosition: Vector2i):
	ownerID = newOwnerID
	piecePosition = newPosition
