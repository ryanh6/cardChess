extends Control

signal draftCompleted(secondPlayerCards: Array[Card], firstPlayerCards: Array[Card])

@onready var instructionLabel: Label = %Instructions
@onready var selectionLabel: Label = %Selected
@onready var confirmationButton: Button = %ConfirmButton
@onready var cardList: Array[]

var secondPlayerCardList: Array[Card] = []
var firstPlayerCardList: Array[Card] = []

func _ready():
	print("hi")
	
func beginDraft():
	print("begin")
