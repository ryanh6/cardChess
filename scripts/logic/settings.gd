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
