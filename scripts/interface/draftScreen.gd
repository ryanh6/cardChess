extends Control

@onready var instructionLabel: Label = %Instructions
@onready var selectionLabel: Label = %Selected
@onready var confirmationButton: Button = %ConfirmButton

var secondPlayerCardList: Array[Card] = []
var firstPlayerCardList: Array[Card] = []

func _ready():
	print("hi")
	
func beginDraft():
	print("begin")
