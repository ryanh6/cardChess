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
	
	var existingCard: Card = findCardByType(cardSelection, currentCardType)
	
	if existingCard != null:
		cardSelection.erase(existingCard)
	elif cardSelection.size() < 2:
		var newCard: Card = Card.new(currentCardType)
		cardSelection.append(newCard)
	
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
	
	selectionLabel.text = "Selected: %d / 2" % cardSelection.size()
	confirmationButton.disabled = cardSelection.size() != 2
	
	for cardInterface in cardList:
		var currentType: Card.type = cardInterface.cardType
		
		var chosenBySecondPlayer: bool = hasCardType(secondPlayerCardList, currentType)
		var currentlySelected: bool = hasCardType(cardSelection, currentType)
		
		cardInterface.visible = (secondPlayerChoosing or not chosenBySecondPlayer)
		
		cardInterface.disabled = false
		cardInterface.setSelected(currentlySelected)
		
func findCardByType(cardList: Array[Card], requestedType: Card.type) -> Card:
	for card in cardList:
		if card.cardType == requestedType:
			return card
			
	return null
	
func hasCardType(cardList: Array[Card], requestedType: Card.type) -> bool:
	return findCardByType(cardList, requestedType) != null
