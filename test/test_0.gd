extends Control

@onready var texture_rect: TextureRect = $TextureRect

var biome_generator : BiomeGenerator = null

func _ready() -> void:
	biome_generator = BiomeGenerator.new(Vector2i(8,8),4)
	for x in biome_generator.size.x:
		for y in biome_generator.size.y:
			biome_generator.set_biome(Vector2i(x,y),randi() % 3)
	for i in range(4):
		biome_generator.expand()
		biome_generator.fill()
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

func _on_switch_scene_pressed() -> void:
	get_tree().change_scene_to_file("res://test/test_1.tscn")
