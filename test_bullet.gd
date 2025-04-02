class_name test_bullet

extends Area2D

signal player_bullet_screen_exit

@export var bullet_speed = 600 # How fast the bullet will move by default (pixels/sec).
@export var bullet_direction = Vector2.RIGHT # which direction the bullet will move by default (vec2).
var screen_size # Size of the game window.d

const my_scene: PackedScene = preload("res://test_bullet.tscn")



func _ready() -> void:
	screen_size = get_viewport_rect().size

static func player_new_bullet(marker,direction) -> test_bullet:
	#print(marker.global_asposition)
	var bullet: test_bullet = my_scene.instantiate()
	bullet.position = marker.global_position
	bullet.bullet_direction = direction
	return bullet

func _process(delta: float) -> void:
	var velocity = bullet_direction.normalized() * bullet_speed
	$AnimatedSprite2D.play()
	
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	player_bullet_screen_exit.emit()
	queue_free() 
