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

func getDirections():
	var directions = [];
	
	match(cardType):
		type.ROOK:
			directions = [Vector2(0, 1), Vector2(0, -1), Vector2(1, 0), Vector2(-1, 0)];
		type.BISHOP:
			directions = [Vector2(1, 1), Vector2(1, -1), Vector2(-1, 1), Vector2(-1, -1)];
		type.KNIGHT:
			directions = [Vector2(2, 1), Vector2(2, -1), Vector2(1, 2), Vector2(-1, 2), Vector2(-2, 1), Vector2(-2, -1), Vector2(1, -2), Vector2(-1, -2)];
		type.ATTACKER:
			directions = [Vector2(0, 1), Vector2(-1, 1), Vector2(1, 1), Vector2(0, 2)];
		type.JUMPER:
			directions = [Vector2(2, 0), Vector2(-2, 2), Vector2(0, 2), Vector2(2, 2), Vector2(-2, 0), Vector2(2, -2), Vector2(0, -2), Vector2(-2, -2)];
			
	return directions;
