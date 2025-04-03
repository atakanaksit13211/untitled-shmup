extends Node2D

@onready var bubbles = $Bubbles

func _ready():
	# Kabarcıkları başlat
	start_bubbles()

func start_bubbles():
	# Her 2 saniyede bir yeni kabarcık oluştur
	while true:
		create_bubble()
		await get_tree().create_timer(2.0).timeout

func create_bubble():
	var bubble = Sprite2D.new()
	var bubble_texture = create_bubble_texture()
	bubble.texture = bubble_texture
	bubble.position = Vector2(
		randf_range(50, get_viewport_rect().size.x - 50),
		get_viewport_rect().size.y + 20
	)
	bubbles.add_child(bubble)
	
	# Kabarcığı yukarı doğru hareket ettir
	var tween = create_tween()
	tween.tween_property(bubble, "position:y", -20, 4.0)
	tween.tween_property(bubble, "modulate:a", 0.0, 1.0)
	tween.tween_callback(bubble.queue_free)

func create_bubble_texture() -> ImageTexture:
	var image = Image.create(8, 8, false, Image.FORMAT_RGBA8)
	
	# Kabarcık çizimi
	for x in range(8):
		for y in range(8):
			var distance = Vector2(x - 4, y - 4).length()
			if distance < 4:
				var alpha = 1.0 - (distance / 4.0)
				image.set_pixel(x, y, Color(0.8, 0.8, 1.0, alpha))
	
	var texture = ImageTexture.create_from_image(image)
	return texture
