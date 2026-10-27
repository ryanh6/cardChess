extends Node
class_name Settings

var roundWin: int = 2;
var boardSize: int = 5;

func setTotalRounds(roundCount: int):
	var count: int = clampi(roundCount, 1, 9)
	
	if count % 2 == 0:
		count += 1;
	
	roundWin = count / 2 + 1
	
func setBoardSize(newSize: int):
	if [5, 7, 9].has(newSize):
		boardSize = newSize

# LIST OF SETTING TO IMPLEMENT IN FUTURE
# - Choose who goes first / second
#	- choose every round? loser goes first? coin flip?
#	- coin flip first round?
# - Move timer or no? (ex: 30 seconds to make move)
# - Randomize card (instead of draft phase)
# - starting player picks their own cards???
# - properly implement board sizes
# - pass button allowed???
# - Add new cards (Pawn, General, King, Queen)
#	- How many cards in waiting zone?
#	- How to pick which card to take? (random, most recent, self pick)
#	- which cards to include in the game?
#	- how many total cards in game (5 - 9)
#	- new hand size???
