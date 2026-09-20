extends Node

# func ready
# - reset board, reset player hands
# - determines who goes first
# - start card draft

# func draft
# - secondPlayer picks 2 cards to keep
# - secondPlayer picks 2 cards for player 1
# - last card auto waiting zone
# - start game

# func playing game
# - 

func _ready() -> void:
	print("hi")
	var rookCard = Card.new(Card.type.ROOK);
	var bishopCard = Card.new(Card.type.BISHOP);
	var knightCard = Card.new(Card.type.KNIGHT);
	var attackerCard = Card.new(Card.type.ATTACKER);
	var jumperCard = Card.new(Card.type.JUMPER);
	
	var player1 = Player.new(0);
	
	player1.currentCards.append(rookCard);
	player1.currentCards.append(knightCard);
	
	for cards in player1.currentCards:
		var spots = cards.getDirections()
		for item in spots:
			var position = Vector2(0, 0) + item
			print(position)
	
