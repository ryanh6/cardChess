@tool
extends Button
class_name CellInterface

signal cellSelected(position: Vector2i)

const WHITEPIECE: Texture2D = preload("res://assets/whitePiece.png")
const BLACKPIECE: Texture2D = preload("res://assets/blackPiece.png")

@export var boardPosition: Vector2i
@export_enum("Empty: -1", "Player 1: 0", "Player 2: 1") var startingOwnerID: int = -1

@onready var pieceView: TextureRect = %PieceInterface
@onready var highlight: ColorRect = %HighlightColor
@onready var throne: Label = %ThroneLabel

func _ready():
	if not Engine.is_editor_hint():
		pressed.connect(sendPositionSignal)
	highlight.visible = false
	displayPiece(startingOwnerID)

func sendPositionSignal():
	cellSelected.emit(boardPosition)

func displayPiece(ownerID: int):
	if ownerID == 0:
		pieceView.texture = WHITEPIECE
	elif ownerID == 1:
		pieceView.texture = BLACKPIECE
	else:
		pieceView.texture = null

func setHighlight(newColor: Color):
	highlight.color = newColor
	highlight.visible = newColor.a > 0.0

func setBackground(enabled: bool):
	flat = not enabled

func setThrone(isThrone: bool):
	throne.visible = isThrone
	
