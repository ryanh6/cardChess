extends Control
class_name GameScreen

signal requestPause
signal requestNextRound
signal requestTitle

@onready var playerOnePanel: PlayerInterface = %Player1Panel
@onready var playerTwoPanel: PlayerInterface = %Player2Panel
@onready var playerOneColumn: VBoxContainer = %Player1Column
@onready var playerTwoColumn: VBoxContainer = %Player2Column
@onready var boardView: BoardInterface = %GameBoard
@onready var playerOneCards: Array[CardInterface] = [%Player1Card1, %Player1Card2]
@onready var playerTwoCards: Array[CardInterface] = [%Player2Card1, %Player2Card2]
@onready var waitingCard: CardInterface = %WaitingCard
@onready var turnLabel: Label = %TurnLabel
@onready var scoreLabel: Label = %ScoreLabel
@onready var pauseButton: Button = %PauseButton
@onready var nextRoundButton: Button = %NextRoundButton

var game: Game

func _ready():
	boardView.cellSelected.connect(onCellSelected)
	
	for index in playerOneCards.size():
		playerOneCards[index].cardSelected.connect(onHandCardSelected.bind(0, index))
		
	for index in playerTwoCards.size():
		playerTwoCards[index].cardSelected.connect(onHandCardSelected.bind(1, index))
	
	pauseButton.pressed.connect(requestPause.emit)
	nextRoundButton.pressed.connect(onRoundAction)
	
func setGame(newGame: Game):
	game = newGame
	_refresh()
	
func _refresh():
	if game == null:
		return
		
	boardView.refresh(game.gameBoard, game.selectedPiece, game.checkLegalMoves())
	playerOnePanel.updatePanel(game.playerList[0].roundsWon, game.currentPlayerID == 0)
	playerTwoPanel.updatePanel(game.playerList[1].roundsWon, game.currentPlayerID == 1)
	
	if game.currentPlayerID == 0:
		playerOneColumn.modulate = Color(1, 1, 1, 1)
		playerTwoColumn.modulate = Color(0.5, 0.5, 0.5, 0.7)
	else:
		playerTwoColumn.modulate = Color(1, 1, 1, 1)
		playerOneColumn.modulate = Color(0.5, 0.5, 0.5, 0.7)
	
	turnLabel.text = "Player %d's Turn" % (game.currentPlayerID + 1)
	scoreLabel.text = "Score %d - %d" % [game.playerList[0].roundsWon, game.playerList[1].roundsWon]
	
	updateHand(0, playerOneCards)
	updateHand(1, playerTwoCards)
	
	waitingCard.setCardType(game.waitingCard)
	waitingCard.disabled = true
	waitingCard.setSelected(false)
	
	if game.phase == Game.gamePhase.ENDROUND or game.phase == Game.gamePhase.ENDGAME:
		nextRoundButton.visible = true
		
	if game.phase == Game.gamePhase.ENDROUND:
		nextRoundButton.text = "Next Round"
	else:
		nextRoundButton.text = "Return To Title Screen"
	
func updateHand(playerID: int, playerHand: Array[CardInterface]):
	var currentHand: Array[Card] = game.playerList[playerID].currentCards
	
	for index in playerHand.size():
		var currentCard: CardInterface = playerHand[index]
		currentCard.visible = index < currentHand.size()
		
		if index >= currentHand.size():
			continue
			
		currentCard.setCardType(currentHand[index].cardType)
		if game.phase != Game.gamePhase.PLAYING or playerID != game.currentPlayerID:
			currentCard.disabled = true
		currentCard.setSelected(playerID == game.currentPlayerID and index == game.selectedCardIndex)
	
func onHandCardSelected(cardType: Card.type, playerID: int, cardIndex: int):
	if game == null or game.phase != Game.gamePhase.PLAYING:
		return
		
	if playerID != game.currentPlayerID:
		return
		
	game.selectedCardIndex = cardIndex
	_refresh()
	
func onCellSelected(cell: Vector2i):
	if game == null or game.phase != Game.gamePhase.PLAYING:
		return
		
	var piece: Piece = game.gameBoard.pieceAt(cell)
	
	if game.selectedPiece != Vector2i(-1, -1) and game.selectedCardIndex >= 0 and game.checkLegalMoves().has(cell):
		game.tryMoves(game.selectedPiece, cell, game.selectedCardIndex)
	elif piece != null and piece.ownerID == game.currentPlayerID:
		game.selectedPiece = cell
		_refresh()

func onRoundAction():
	if game.phase == Game.gamePhase.ENDROUND:
		requestNextRound.emit()
	else:
		requestTitle.emit()
