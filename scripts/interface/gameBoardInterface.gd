extends Control
class_name BoardInterface

signal cellSelected(position: Vector2i)

const cellScene: PackedScene = preload("res://scenes/components/cellInterface.tscn")

@onready var cellGrid: GridContainer = %CellGrid
@onready var boardTexture: TextureRect = %BoardTexture

var cells: Array[CellInterface] = []
var currentBoardSize: int = 0

func _ready():
	boardTexture.resized.connect(updateBoardRotation)
	updateBoardRotation()
	buildGrid(5)
	
func buildGrid(newGridSize: int):
	if newGridSize == currentBoardSize:
		return
		
	clearGrid()
	currentBoardSize = newGridSize
	cellGrid.columns = newGridSize
	
	var boardImage: bool = newGridSize == 5
	boardTexture.visible = boardImage
	setBoardMargins(boardImage)
	
	for screenY in newGridSize:
		for screenX in newGridSize:
			var screenPosition: Vector2i = Vector2i(screenX, screenY)
			var actualPosition = screenToBoard(screenPosition, newGridSize)
			var cell: CellInterface = cellScene.instantiate()
			
			cell.name = "Cell%d%d" % [screenX, screenY]
			cell.boardPosition = actualPosition
			cellGrid.add_child(cell)
			
			cell.setBackground(not boardImage)
			cell.setThrone(not boardImage and isThrone(actualPosition, newGridSize))
			cell.cellSelected.connect(onCellSelected)
			
			cells.append(cell)
			
func clearGrid():
	for child in cellGrid.get_children():
		cellGrid.remove_child(child)
		child.queue_free()
	
	cells.clear()
	currentBoardSize = 0
	
func setBoardMargins(useImage: bool):
	var margins: float
	
	if useImage == true:
		margins = 17.5
	else:
		margins = 0.0
	
	cellGrid.offset_left = margins
	cellGrid.offset_top = margins
	cellGrid.offset_right = -margins
	cellGrid.offset_bottom = -margins
	
func isThrone(position: Vector2i, gridSize: int):
	var centerColumn: int = gridSize / 2
	if position == Vector2i(centerColumn, 0) or position == Vector2i(centerColumn, gridSize - 1):
		return position

func screenToBoard(screenPosition: Vector2i, gridSize: int):
	return Vector2i(screenPosition.y, gridSize - 1 - screenPosition.x)
	
func updateBoardRotation():
	boardTexture.pivot_offset = boardTexture.size / 2
	boardTexture.rotation = PI / 2

func refresh(gameBoard: Board, selectedCell: Vector2i, legalMovesList: Array[Vector2i]):
	if gameBoard.size != currentBoardSize:
		buildGrid(gameBoard.size)
		
	for cell in cells:
		var piece: Piece = gameBoard.pieceAt(cell.boardPosition)
		
		if piece == null:
			cell.displayPiece(-1)
		else:
			cell.displayPiece(piece.ownerID)
			
		if cell.boardPosition == selectedCell:
			cell.setHighlight(Color(0, 1, 0, 0.5))
		elif legalMovesList.has(cell.boardPosition):
			cell.setHighlight(Color(0, 1, 1, 0.5))
		else:
			cell.setHighlight(Color.TRANSPARENT)

func onCellSelected(position: Vector2i):
	cellSelected.emit(position)
