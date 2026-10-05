extends Control
class_name DraftScreen

signal draftCompleted(secondPlayerCards: Array[Card], firstPlayerCards: Array[Card])

@onready var instructionLabel: Label = %Instructions
@onready var selectionLabel: Label = %Selected
@onready var confirmationButton: Button = %ConfirmButton
@onready var cardList: Array[CardInterface] = [%RookCard, %BishopCard, %KnightCard, %AttackerCard, %JumperCard]

var secondPlayerChoosing: bool = true
var secondPlayerCardList: Array[Card] = []
var firstPlayerCardList: Array[Card] = []

func _ready():
	for index in cardList.size():
		var cardView: CardInterface = cardList[index]
		cardView.setCardType(index)
		cardView.cardSelected.connect(onCardSelected)
	confirmationButton.pressed.connect(onConfirmPressed)
	
func beginDraft():
	secondPlayerChoosing = true
	secondPlayerCardList.clear()
	firstPlayerCardList.clear()
	visible = true
	_refresh()

func onCardSelected(currentCardType: Card.type):
	var cardSelection: Array[Card]
	
	if secondPlayerChoosing:
		cardSelection = secondPlayerCardList
	else:
		cardSelection = firstPlayerCardList
		
	if cardSelection.has(currentCardType):
		cardSelection.erase(currentCardType)
	elif cardSelection.size() < 2:
		cardSelection.append(currentCardType)
	
	_refresh()

func onConfirmPressed():
	if secondPlayerChoosing:
		secondPlayerChoosing = false
		_refresh()
	else:
		draftCompleted.emit(secondPlayerCardList, firstPlayerCardList)

func _refresh():
	var cardSelection: Array[Card]
	
	if secondPlayerChoosing:
		cardSelection = secondPlayerCardList
		instructionLabel.text = "Player 2: Choose Two Cards for Yourself"
		confirmationButton.text = "Continue"
	else:
		cardSelection = firstPlayerCardList
		instructionLabel.text = "Player 2: Choose Two Cards for Player 1"
		confirmationButton.text = "Start Game"
	
	selectionLabel.text = "Selected %d / 2" % cardSelection.size()
	confirmationButton.disabled = cardSelection.size() != 2
	
	for card in cardList:
		var currentType = card.cardType
		
		card.visible = secondPlayerChoosing or not secondPlayerCardList.has(currentType)
		card.disabled = false
		card.setSelected(cardSelection.has(currentType))
