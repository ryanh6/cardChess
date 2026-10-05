extends Control
class_name PauseScreen

signal requestResume
signal requestReturnToTitle

@onready var resumeButton: Button = %ResumeButton
@onready var returnButton: Button = %ReturnToTitleButton

func _ready():
	resumeButton.pressed.connect(requestResume.emit)
	returnButton.pressed.connect(requestReturnToTitle.emit)
