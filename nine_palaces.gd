class_name NinePalaces extends RefCounted

enum State{
	ROW,
	COLUMN,
	CENTER,
}

var biome : BiomeGenerator

var key : Vector2i

func _init(biome : BiomeGenerator):
	self.biome = biome

func get_biome(offset : Vector2i) -> int:
	return biome.get_biome(offset + key)

func set_biome(offset : Vector2i, value : int):
	biome.set_biome(offset + key, value)
