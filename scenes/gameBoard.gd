extends Sprite2D

const BOARDSIZE = 5
const GAMEPIECE = preload("res://scenes/gamePiece.tscn")

const BLACKPIECE = preload("res://assets/blackPiece.png")
const WHITEPIECE = preload("res://assets/whitePiece.png")

var board: Array

func _ready() -> void:
	print("hi")
	createBoard()
	
func createBoard() -> void:
	board.append([1, 1, 1, 1, 1])
	board.append([0, 0, 0, 0, 0])
	board.append([0, 0, 0, 0, 0])
	board.append([0, 0, 0, 0, 0])
	board.append([2, 2, 2, 2, 2])
	displayBoard()
	
func displayBoard() -> void:
	for i in BOARDSIZE:
		for j in BOARDSIZE:
			if (board[i][j] != 0):
				var piece = GAMEPIECE.instantiate()
				add_child(piece)
				piece.scale = Vector2(0.15, 0.15)
				piece.global_position = Vector2i(j * 120 + 335, i * 120 + 87)
			
				if (board[i][j] == 1):
					piece.texture = BLACKPIECE
				else:
					piece.texture = WHITEPIECE
