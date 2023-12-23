extends GridMap

@onready var tileset = preload("res://ASSETS/BLENDER/DemoTiles.tres")

func _ready():
	set_spawn()

func set_spawn():
	place_tile(1, 1, 1)
	place_tile(0, 1, 1)
	place_tile(-1, 1, 1)
	place_tile(1, 0, 1)
	place_tile(0, 0, 1)
	place_tile(-1, 0, 1)	
	place_tile(1, -1, 1)
	place_tile(0, -1, 1)
	place_tile(-1, -1, 1)
	place_tile(1, 2, 0)
	place_tile(0, 2, 0)
	place_tile(-1, 2, 0)
	place_tile(1, -2, 0)
	place_tile(0, -2, 0)
	place_tile(-1, -2, 0)
func place_tile(x, z, tile_index):
	var tile_coordinates = Vector3(x, 0, z)  # Assuming a 2D grid, so Z-coordinate is 0
	set_cell_item(tile_coordinates, tile_index)
