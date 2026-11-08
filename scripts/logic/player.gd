extends RefCounted
class_name Player

var id: int;
var currentCards: Array[Card] = []
var roundsWon: int;

func _init(newID: int) -> void:
	id = newID;
