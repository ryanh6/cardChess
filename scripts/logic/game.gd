extends Node
class_name Game

enum gamePhase {
	DRAFT,
	PLAYING,
	ENDROUND,
	ENDGAME
}

signal finishRound(winnerID: int)
signal finishMatch(winnerID: int)

var gameBoard: Board = Board.new()
var playerList: Array[Player] = [Player.new(0), Player.new(1)]
var matchSettings: Settings = Settings.new()
var phase = gamePhase.DRAFT

var currentPlayerID: int = 0
var secondPlayerID: int = 1
var waitingCard = Card.type.ROOK
var selectedPiece: Vector2i
var selectedCardIndex: int
var throneOccupantID: int

func startMatch(totalRounds: int, boardSize: int):
	matchSettings.setTotalRounds(totalRounds)
	matchSettings.setBoardSize(boardSize)
	gameBoard.setSize(matchSettings.boardSize)
	
	for players in playerList:
		players.roundsWon = 0
	
	startRound()

func startRound():
	gameBoard.resetBoard()
	
	for player in playerList:
		player.currentCards.clear()
		
	phase = gamePhase.DRAFT
	currentPlayerID = 0;
	selectedPiece = Vector2i(-1, -1)
	selectedCardIndex = -1
	throneOccupantID = -1
		
func draftPhase():
	print("hi")
	
func checkLegalMoves():
	if phase != gamePhase.PLAYING or selectedCardIndex < 0:
		return []
		
	var currentPiece: Piece = gameBoard.pieceAt(selectedPiece)
	if currentPiece == null or currentPiece.ownerID != currentPlayerID:
		return []
	
	return playerList[currentPlayerID].currentCards[selectedCardIndex].getMoves(gameBoard, currentPiece)
	
func tryMoves():
	print("moves")
	
func rotateCards(cardIndex: int):
	var usedCard = playerList[currentPlayerID].currentCards[cardIndex]
	playerList[currentPlayerID].currentCards[cardIndex] = waitingCard
	waitingCard = usedCard
	
func checkThrone():
	print("check")
	
func opponentThrone():
	print("opponent")
	
func endRound():
	print("hi")
