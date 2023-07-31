class_name Chunk extends Control

const UP = 0
const DOWN = 1
const LEFT = 2
const RIGHT = 3

const DIRECTIONS = [Vector2i(0,-1),Vector2i(0,1),Vector2i(-1,0),Vector2i(1,0)]

@onready 
var texture_rect: TextureRect = $TextureRect

static var world : Dictionary

var key : Vector2i = Vector2i.ZERO

var biome_generator : BiomeGenerator = BiomeGenerator.new(Vector2i(8,8),5)

var _buttons : Array[Button] = [null, null, null, null]

var _neighbors : Array[Chunk] = [null, null, null, null]

func _ready() -> void:
	position = key * 256

	_buttons = [$Up,$Down,$Left,$Right]
	
	world[key] = self
	refresh_neighbors()

	for x in biome_generator.size.x:
		for y in biome_generator.size.y:
			biome_generator.set_biome(Vector2i(x,y),[0,0,0,0,0,1,1,1,1,2].pick_random())
	generate_image()

func refresh_neighbors() -> void:
	for i in range(4):
		var neighbor : Chunk = world.get(key + DIRECTIONS[i], null)
		_neighbors[i] = neighbor
		if neighbor != null:
			_buttons[i].hide()

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

func _on_create_chunk_pressed(direction: int) -> void:
	if _neighbors[direction] != null:
		return
	var chunk : Chunk = load("res://test/test_2.tscn").instantiate()
	chunk.key = key + DIRECTIONS[direction]
	get_parent().add_child(chunk)
	refresh_neighbors()

func _on_expand_pressed() -> void:
	for i in range(_neighbors.size()):
		if _neighbors[i] != null:
			var neighbor : Chunk = _neighbors[i]
			if neighbor.biome_generator.step >= biome_generator.step:
				var shrink_count : int = neighbor.biome_generator.step - biome_generator.step
				for j in range(shrink_count):
					neighbor.biome_generator.shrink()
				match i:
					UP:
						for x in biome_generator.size.x:
							biome_generator.set_biome(Vector2i(x,0),neighbor.biome_generator.get_biome(Vector2i(x,biome_generator.size.y - 1)))
					DOWN:
						for x in biome_generator.size.x:
							biome_generator.set_biome(Vector2i(x,biome_generator.size.y - 1),neighbor.biome_generator.get_biome(Vector2i(x,0)))
					LEFT:
						for y in biome_generator.size.y:
							biome_generator.set_biome(Vector2i(0,y),neighbor.biome_generator.get_biome(Vector2i(biome_generator.size.x - 1,y)))
					RIGHT:
						for y in biome_generator.size.y:
							biome_generator.set_biome(Vector2i(biome_generator.size.x - 1,y),neighbor.biome_generator.get_biome(Vector2i(0,y)))
				for j in range(shrink_count):
					neighbor.biome_generator.expand()
	biome_generator.expand()
	biome_generator.fill()
	generate_image()
