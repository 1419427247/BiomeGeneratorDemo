extends Control

@onready var texture_rect: TextureRect = $HBoxContainer/TextureRect

@onready var option_button: OptionButton = $HBoxContainer/VBoxContainer/OptionButton

var biome_generator : BiomeGenerator = null

func _ready() -> void:
	_on_clear_pressed()

enum{
	RANDOM,
	SQUARE,
	CIRCLE,
}

func _on_clear_pressed() -> void:
	match option_button.selected:
		RANDOM:
			biome_generator = BiomeGenerator.new(Vector2i(8,8),6)
			for x in biome_generator.size.x:
				for y in biome_generator.size.y:
					biome_generator.set_biome(Vector2i(x,y),randi() % 3)
					biome_generator.set_biome(Vector2i(x,y),randi() % 3)
		SQUARE:
			biome_generator = BiomeGenerator.new(Vector2i(16,16),5)
			for x in range(3,biome_generator.size.x - 3):
				for y in range(3,biome_generator.size.y - 3):
					biome_generator.set_biome(Vector2i(x,y),2)
			for x in range(4,biome_generator.size.x - 4):
				for y in range(4,biome_generator.size.y - 4):
					biome_generator.set_biome(Vector2i(x,y),1)
		CIRCLE:
			biome_generator = BiomeGenerator.new(Vector2i(16,16),5)
			for x in range(1,biome_generator.size.x - 1):
				for y in range(1,biome_generator.size.y - 1):
					if (Vector2i(x,y) - biome_generator.size / 2).length() < 6:
						biome_generator.set_biome(Vector2i(x,y),1)
	generate_image()

func _on_expand_pressed() -> void:
	biome_generator.expand()
	biome_generator.fill()
	generate_image()

func _on_smooth_pressed() -> void:
	biome_generator.smooth()
	generate_image()

func generate_image() -> void:
	var image : Image = Image.create(biome_generator.size.x,biome_generator.size.y,true,Image.FORMAT_RGB8)
	for x in biome_generator.size.x:
		for y in biome_generator.size.y:
			var color : Color = Color(0,0,0)
			if biome_generator.get_biome(Vector2i(x,y)) == 0:
				color = Color(0,0,1)
			elif biome_generator.get_biome(Vector2i(x,y)) == 1:
				color = Color(0,1,0)
			elif biome_generator.get_biome(Vector2i(x,y)) == 2:
				color = Color(1,1,0)
			image.set_pixel(x,y,color)
	texture_rect.texture = ImageTexture.create_from_image(image)

func _on_noise_pressed() -> void:
	for x in biome_generator.size.x:
		for y in biome_generator.size.y:
			biome_generator.set_biome(Vector2i(x,y),randi() % 3)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var biome_key = Vector2i(texture_rect.get_local_mouse_position() / texture_rect.size * Vector2(biome_generator.size))
		if biome_key.x >= 0 and biome_key.x < biome_generator.size.x and biome_key.y >= 0 and biome_key.y < biome_generator.size.y:
			biome_generator.set_biome(biome_key,0)
	generate_image()

func _on_switch_scene_pressed() -> void:
	get_tree().change_scene_to_file("res://test/test_2.tscn")


func _on_rim_pressed() -> void:
	var filter_size : int = 1
	var step : int = 1
	var new_biome : Dictionary = {}


	for x in range(filter_size,biome_generator.size.x - filter_size,step):
		for y in range(filter_size,biome_generator.size.y - filter_size,step):
			var is_rim : bool = false
			var id = biome_generator.get_biome(Vector2i(x,y))
			for i in range(-filter_size,filter_size + 1):
				for j in range(-filter_size,filter_size + 1):
					if biome_generator.get_biome(Vector2i(x + i,y + j)) != id:
						is_rim = true
						break
			if is_rim:
				new_biome[Vector2i(x,y)] = 1
			else:
				new_biome[Vector2i(x,y)] = 0
	
	for i in range(biome_generator.size.x):
		for j in range(biome_generator.size.y):
			if new_biome.has(Vector2i(i,j)):
				biome_generator.set_biome(Vector2i(i,j),new_biome[Vector2i(i,j)])
			else:
				biome_generator.set_biome(Vector2i(i,j),0)
	generate_image()
