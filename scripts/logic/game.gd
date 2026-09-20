extends Node
class_name Game

enum gamePhase {
	DRAFT,
	PLAYING,
	ENDROUND,
	ENDGAME
}

var gameBoard: Board = Board.new()
var playerList: Array[Player] = [Player.new(0), Player.new(1)]

func startRound():
	gameBoard.resetBoard()
	
	for player in playerList:
		player.currentCards.clear()
		
func draftPhase():
	print("hi")
	
func moveCard():
	print("card")
	
func checkThrone():
	print("check")
	
func finishRound():
	print("hi")
