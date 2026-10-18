extends Button
class_name CardInterface

signal cardSelected(cardType: Card.type)

var cardType: Card.type = Card.type.ROOK

@onready var cardIcon: TextureRect = %CardIcon
@onready var cardName: Label = %CardName
@onready var border: Panel = %SelectedBorder

func _ready() -> void:
	get_window().min_size = Vector2i(960, 540)
	get_window().mode = Window.MODE_FULLSCREEN
	
	pressed.connect(onPressed)
	refresh()

func setSelected(value: bool) -> void:
	button_pressed = value
	border.visible = value

func refresh() -> void:
	cardIcon.texture = Card.getIcon(cardType)
	cardName.text = Card.getName(cardType)

func setCardType(newCardType: Card.type) -> void:
	cardType = newCardType
	
	if is_node_ready():
		refresh()

func onPressed():
	cardSelected.emit(cardType)
