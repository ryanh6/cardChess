extends Node
class_name Game

enum gamePhase {
	DRAFT,
	PLAYING,
	ENDROUND,
	ENDGAME
}

signal changed
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
	
func tryMoves(fromLocation: Vector2i, toLocation: Vector2i, cardIndex: int):
	selectedPiece = fromLocation
	selectedCardIndex = cardIndex
	
	if not checkLegalMoves().has(toLocation):
		return false
		
	gameBoard.movePiece(fromLocation, toLocation)
	rotateCards(cardIndex)
	
	if gameBoard.countTeamPieces(1 - currentPlayerID) == 0:
		endRound(currentPlayerID)
		changed.emit()
		return true
	
	checkThrone(currentPlayerID, toLocation)
	
	if phase == gamePhase.PLAYING:
		currentPlayerID = 1 - currentPlayerID
		
	selectedPiece = Vector2i(-1, -1)
	selectedCardIndex = -1
	changed.emit()
	return true
	
func rotateCards(cardIndex: int):
	var usedCard = playerList[currentPlayerID].currentCards[cardIndex]
	playerList[currentPlayerID].currentCards[cardIndex] = waitingCard
	waitingCard = usedCard
	
func checkThrone(playerID: int, newLocation: Vector2i):
	if throneOccupantID != -1:
		var throne: Vector2i = opponentThrone(throneOccupantID)
		var occupant: Piece = gameBoard.pieceAt(throne)
		
		if occupant != null and occupant.ownerID == throneOccupantID:
			endRound(throneOccupantID)
			return
		
		throneOccupantID = -1
	
	if newLocation == opponentThrone(playerID):
		throneOccupantID = playerID
	
func opponentThrone(playerID: int):
	if playerID == 0:
		return Vector2i(gameBoard.boardSize / 2, 0)
	else:
		return Vector2i(gameBoard.boardSize / 2, gameBoard.boardSize - 1)
	
func endRound(winnerID: int):
	playerList[winnerID].roundsWon += 1;
	
	if playerList[winnerID].roundsWon >= matchSettings.roundWin:
		phase = gamePhase.ENDGAME
	else:
		phase = gamePhase.ENDROUND
		
	finishRound.emit(winnerID)
	if phase == gamePhase.ENDGAME:
		finishMatch.emit(winnerID)
