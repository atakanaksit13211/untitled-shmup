extends Area2D

signal hit
signal shoot

@export var speed = 400 # How fast the player will move (pixels/sec).
@export var shooting_speed = 400 # How fast the player will shoot (delay ms between shots).
var screen_size # Size of the game window.d

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


func _load_config() -> void:
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load("user://global.cfg")

	# If the file didn't load, ignore it.
	if err != OK:
		return

	# Iterate over all sections.
	for control_options in config.get_sections():
		# Fetch the data for each section.
		var isMouseMode = config.get_value(control_options, "isMouseMode")
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_just_released("shoot"):
		shoot.emit()
	#if(): #mouse movement
		

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	#if velocity.x != 0:
	#	$AnimatedSprite2D.animation = "default"
	#	$AnimatedSprite2D.flip_v = false
	#	# See the note below about the following boolean assignment.
	#	$AnimatedSprite2D.flip_h = velocity.x < 0
	#	$AnimatedSprite2D.flip_v = velocity.y > 0 #make sure crossadswd movement down looks normal
	#elif velocity.y != 0:
	#	$AnimatedSprite2D.animation = "default"
	#	$AnimatedSprite2D.flip_v = velocity.y > 0


func get_bullet_spawn_point() -> Marker2D:
	return $BulletSpawnPoint
	


func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
