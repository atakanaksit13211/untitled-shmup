extends Camera2D

@export var scroll_speed = 300

func _process(delta: float) -> void:
	position += Vector2.RIGHT * scroll_speed * delta
