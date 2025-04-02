extends Node2D

var playerBulletsOnScreen: int = 0;
@export var maxPlayerBullets: int

func _ready() -> void:
	$Player.start($StartPosition.position)


func _on_player_shoot() -> void:
	if(playerBulletsOnScreen < maxPlayerBullets):
		playerBulletsOnScreen += 1 
		var scene_instance = test_bullet.player_new_bullet($Player.get_bullet_spawn_point(), Vector2.RIGHT)
		scene_instance.player_bullet_screen_exit.connect(_on_player_bullet_screen_exit)
		add_child(scene_instance)


func _on_player_bullet_screen_exit():
	playerBulletsOnScreen -= 1
