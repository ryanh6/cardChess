@tool
extends TextureRect
class_name PieceInterface

const WHITEPIECE: Texture2D = preload("res://assets/whitePiece.png")
const BLACKPIECE: Texture2D = preload("res://assets/blackPiece.png")

@export_enum("Empty: -1", "Player 1: 0", "Player 2: 1") var ownerID: int = -1:
	set(value):
		ownerID = value
		updateTexture()
		
func _ready():
	updateTexture()
	
func updateTexture():
	if ownerID == 0:
		texture = WHITEPIECE
	elif ownerID == 1:
		texture = BLACKPIECE
	else:
		texture = null
