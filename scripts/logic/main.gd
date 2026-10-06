extends Control

@onready var titleScreen: TitleScreen = %TitleScreen
@onready var optionScreen: OptionScreen = %OptionScreen
@onready var gameScreen: GameScreen = %GameScreen
@onready var draftScreen: DraftScreen = %DraftScreen
@onready var pauseScreen: PauseScreen = %PauseScreen

var currentGame: Game = Game.new()
var bestOfDefault: int = 3
var boardSizeDefault: int = 5

func _ready():
	titleScreen.requestStart.connect(startMatch)
	titleScreen.requestOptions.connect(showOptions)
	
	optionScreen.requestBack.connect(showTitleScreen)
	optionScreen.bestOfChange.connect(setBestOf)
	optionScreen.boardSizeChange.connect(setBoardSize)
	
	gameScreen.requestPause.connect(showPauseScreen)
	gameScreen.requestNextRound.connect(nextRound)
	gameScreen.requestTitle.connect(showTitleScreen)
	
	draftScreen.draftCompleted.connect(completeDraft)
	
	pauseScreen.requestResume.connect(hidePauseScreen)
	pauseScreen.requestReturnToTitle.connect(showTitleScreen)
	
	currentGame.changed.connect(onGameChanged)
	showTitleScreen()
	
func setBestOf(newBestOf):
	bestOfDefault = newBestOf

func setBoardSize(newBoardSize):
	boardSizeDefault = newBoardSize

func showTitleScreen():
	titleScreen.visible = true
	optionScreen.visible = false
	gameScreen.visible = false
	draftScreen.visible = false
	pauseScreen.visible = false
	
func showOptions():
	titleScreen.visible = false
	optionScreen.visible = true
	
func startMatch():
	titleScreen.visible = false
	optionScreen.visible = false
	gameScreen.visible = true
	
	currentGame.startMatch(bestOfDefault, boardSizeDefault)
	gameScreen.setGame(currentGame)
	draftScreen.beginDraft()
	
func completeDraft(secondPlayerHand: Array[Card], firstPlayerHand: Array[Card]):
	if currentGame.draftPhase(secondPlayerHand, firstPlayerHand):
		draftScreen.visible = false
		gameScreen._refresh()
		
func nextRound():
	currentGame.startRound()
	draftScreen.beginDraft()
	
func showPauseScreen():
	pauseScreen.visible = true
	
func hidePauseScreen():
	pauseScreen.visible = false
	
func onGameChanged():
	if gameScreen.visible:
		gameScreen._refresh()
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and gameScreen.visible and not draftScreen.visible:
		pauseScreen.visible = not pauseScreen.visible
