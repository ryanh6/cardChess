extends Control
class_name OptionScreen

signal requestBack
signal bestOfChange(newValue: int)
signal boardSizeChange(newSize: int)

@onready var roundsOption: OptionButton = %RoundsOptions
@onready var boardSizeOption: OptionButton = %BoardSizeOptions
@onready var backButton: Button = %BackButton

func _ready():
	for value in [1, 3, 5, 7, 9]:
		roundsOption.add_item("Best of %d" % value, value)
	for value in [5, 7, 9]:
		boardSizeOption.add_item("%d x %d" % [value, value], value)
	
	roundsOption.select(1)
	boardSizeOption.select(0)
	
	roundsOption.item_selected.connect(onRoundSelected)
	boardSizeOption.item_selected.connect(onBoardSizeSelected)
	backButton.pressed.connect(requestBack.emit)
	
func onRoundSelected(index: int):
	bestOfChange.emit(roundsOption.get_item_id(index))
	
func onBoardSizeSelected(index: int):
	boardSizeChange.emit(boardSizeOption.get_item_id(index))
	
