extends Sprite2D

func playerProperties(newPosition: Vector2, newScale: float, newTexture: Texture2D) -> void:
	global_position = newPosition
	scale = Vector2(newScale, newScale)
	texture = newTexture
