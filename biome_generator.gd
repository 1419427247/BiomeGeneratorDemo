@tool
class_name BiomeGenerator extends RefCounted

var size : Vector2i = Vector2i(0,0)

var step : int = 0

var max_step : int = 0

var max_size : Vector2i = Vector2i(0,0)

var biomes : PackedByteArray = PackedByteArray()

var random_number_generator : RandomNumberGenerator = RandomNumberGenerator.new()

var _temporary_record_x : int = 0
var _temporary_record_y : int = 0

func _init(size : Vector2i,max_step : int,seed : int = 0) -> void:
	self.size = size
	self.step = 0
	self.max_step = max_step
	self.max_size = Vector2i((size.x - 1) * 2 ** max_step + 1,(size.y - 1) * 2 ** max_step + 1)
	self.biomes.resize(max_size.x * max_size.y)
	
	self.random_number_generator.seed = seed
	_temporary_record_x = (2 ** (max_step - step)) * max_size.x
	_temporary_record_y = (2 ** (max_step - step))
	

func expand() -> void:
	if step >= max_step:
		return
	step += 1
	size = size * 2 - Vector2i.ONE
	
	_temporary_record_x = (2 ** (max_step - step)) * max_size.x
	_temporary_record_y = (2 ** (max_step - step))

func shrink() -> void:
	if step <= 0:
		return
	step -= 1
	size = (size + Vector2i.ONE) / 2
	
	_temporary_record_x = (2 ** (max_step - step)) * max_size.x
	_temporary_record_y = (2 ** (max_step - step))

func get_biome(key : Vector2i) -> int:
	var index : int = key.x * _temporary_record_x + key.y * _temporary_record_y
	return biomes[index]

func set_biome(key : Vector2i,value : int) -> void:
	var index : int = key.x * _temporary_record_x + key.y * _temporary_record_y
	biomes[index] = value

func foreach_nine_palaces(callable : Callable) -> void:
	var nine_palaces : NinePalaces = NinePalaces.new(self)
	for x in range(1,size.x,2):
		for y in range(0,size.y,2):
			nine_palaces.key = Vector2i(x,y)
			callable.call(NinePalaces.State.ROW,nine_palaces)
	for x in range(0,size.x,2):
		for y in range(1,size.y,2):
			nine_palaces.key = Vector2i(x,y)
			callable.call(NinePalaces.State.COLUMN,nine_palaces)
	for x in range(1,size.x - 1,2):
		for y in range(1,size.y - 1,2):
			nine_palaces.key = Vector2i(x,y)
			callable.call(NinePalaces.State.CENTER,nine_palaces)

func fill():
	foreach_nine_palaces(
		func(state : NinePalaces.State,nine_palaces : NinePalaces):
			var center_biome : int = nine_palaces.get_biome(Vector2i.ZERO)
			match state:
				NinePalaces.State.ROW:
					var left_biome : int = nine_palaces.get_biome(Vector2i(-1,0))
					var right_biome : int = nine_palaces.get_biome(Vector2i(1,0))
					nine_palaces.set_biome(Vector2i.ZERO,[left_biome,right_biome][random_number_generator.randi() % 2])
				NinePalaces.State.COLUMN:
					var top_biome : int = nine_palaces.get_biome(Vector2i(0,-1))
					var bottom_biome : int = nine_palaces.get_biome(Vector2i(0,1))
					nine_palaces.set_biome(Vector2i.ZERO,[top_biome,bottom_biome][random_number_generator.randi() % 2])
				NinePalaces.State.CENTER:
					var top_biome : int = nine_palaces.get_biome(Vector2i(0,-1))
					var bottom_biome : int = nine_palaces.get_biome(Vector2i(0,1))
					var left_biome : int = nine_palaces.get_biome(Vector2i(-1,0))
					var right_biome : int = nine_palaces.get_biome(Vector2i(1,0))
					nine_palaces.set_biome(Vector2i.ZERO,[top_biome,bottom_biome,left_biome,right_biome][random_number_generator.randi() % 4])
	)

func smooth(filter_size : int = 1,step : int = 1) -> void:
	for x in range(filter_size,size.x - filter_size,step):
		for y in range(filter_size,size.y - filter_size,step):
			var biomes : Array = []
			for i in range(-filter_size,filter_size + 1):
				for j in range(-filter_size,filter_size + 1):
					biomes.append(get_biome(Vector2i(x + i,y + j)))
			var count : Dictionary = {}
			for biome in biomes:
				if count.has(biome):
					count[biome] += 1
				else:
					count[biome] = 1
			var max_count : int = 0
			var max_biome : int = 0
			for biome in count:
				if count[biome] > max_count:
					max_count = count[biome]
					max_biome = biome
			set_biome(Vector2i(x,y),max_biome)
