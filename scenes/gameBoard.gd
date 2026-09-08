extends Sprite2D

const BOARDSIZE = 5
const GAMEPIECE = preload("res://scenes/gamePiece.tscn")
const BASECARD = preload("res://scenes/moveCard.tscn")
const PLAYER = preload("res://scenes/player.tscn")

const BLACKPIECE = preload("res://assets/blackPiece.png")
const WHITEPIECE = preload("res://assets/whitePiece.png")

const ROOKCARD = preload("res://assets/rookCard.png")
const BISHOPCARD = preload("res://assets/bishopCard.png")
const KNIGHTCARD = preload("res://assets/knightCard.png")
const ATTACKERCARD = preload("res://assets/attackerCard.png")
const JUMPERCARD = preload("res://assets/jumperCard.png")

const OXPLAYERICON = preload("res://assets/oxPlayer.png")
const WOLFPLAYERICON = preload("res://assets/wolfPlayer.png")

var board: Array

func _ready() -> void:
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
					
	for i in range(5):
		var card = BASECARD.instantiate()
		add_child(card)
		card.scale = Vector2(0.3, 0.3)
		card.global_position = Vector2i(i * 150 + 150, i * 50 + 150)
		
		if (i == 0):
			card.texture = ROOKCARD
		elif (i == 1):
			card.texture = BISHOPCARD
		elif (i == 2):
			card.texture = KNIGHTCARD
		elif (i == 3):
			card.texture = ATTACKERCARD
		else:
			card.texture = JUMPERCARD
			
	var player1 = PLAYER.instantiate()
	add_child(player1)
	player1.scale = Vector2(0.4, 0.4)
	player1.global_position = Vector2(200, 200)
	player1.texture = OXPLAYERICON
	
	var player2 = PLAYER.instantiate()
	add_child(player2)
	player2.scale = Vector2(0.4, 0.4)
	player2.global_position = Vector2(900, 500)
	player2.texture = WOLFPLAYERICON
