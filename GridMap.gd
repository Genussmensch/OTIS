extends GridMap

@onready var tileset = preload("res://ASSETS/BLENDER/DemoTiles.tres")

var doors = []
var enemies = []

var roomGen = preload("res://RoomGen.tscn").instantiate()

func get_gridmaps() -> Array:
	var gridmaps = []
	
	for child in roomGen.get_children():
		if child is TileMap:
			gridmaps.push_back(child as TileMap)
			
	return gridmaps

func redraw():
	var grids = get_gridmaps()
	
	var gridSize = Vector2i(21,21)
	
	for x in range(-3, 3):
		for y in range(-3, 3):
			var grid = grids.pick_random()
			
			draw_tiles(gridSize, Vector2i(x, y) * gridSize, grid)



func on_exit():
	print("PlayerExited!")
	for door in doors:
		remove_child(door)
	
	for enemy in enemies:
		remove_child(enemy)
		
	doors = []
	enemies = []
	redraw()

func _ready():
	redraw()
	
	SignalBus.connect("_exit", on_exit) 
	
	print(roomGen.find_child("TileMap"))
	#set_spawn()

func draw_tiles(gridSize: Vector2i, offset: Vector2i, pattern: TileMap):

	for baseCell in pattern.get_used_cells(0):
		
		var atlas = pattern.get_cell_atlas_coords(0, baseCell)
		var baseItem = atlas.x + 4 * atlas.y
		
		var position = Vector3i(offset.x, 0, offset.y) + Vector3i(baseCell.x, 0, baseCell.y)
		
		if atlas == Vector2i(0, 1):
			spawn_enemy(position * Vector3i(2, 0, 2))
		if atlas == Vector2i(2 , 0):
			spawn_exit(position * Vector3i(2, 0, 2))
		
		if baseItem > 1:
			baseItem = 0
		
		set_cell_item(position, 1 - baseItem)

func spawn_enemy(position : Vector3i):
	var enemy
	if randi_range(0, 100) > 10:
		enemy = load("res://tumbler.tscn").instantiate()
		if randi_range(0, 100) > 50:
			enemy = load("res://redTumbler.tscn").instantiate()
		enemy.global_position = position
		enemies.push_back(enemy)
		add_child(enemy)

func spawn_exit(position : Vector3i):
	var exit = load("res://EXIT.tscn").instantiate()
	exit.global_position = position
	doors.push_back(exit)
	add_child(exit)
		
#func set_spawn():
	#place_tile(1, 1, 1)
	#place_tile(0, 1, 1)
	#place_tile(-1, 1, 1)
	#place_tile(1, 0, 1)
	#place_tile(0, 0, 1)
	#place_tile(-1, 0, 1)	
	#place_tile(1, -1, 1)
	#place_tile(0, -1, 1)
	#place_tile(-1, -1, 1)
	#place_tile(1, 2, 0)
	#place_tile(0, 2, 0)
	#place_tile(-1, 2, 0)
	#place_tile(1, -2, 0)
	#place_tile(0, -2, 0)
	#place_tile(-1, -2, 0)
#func place_tile(x, z, tile_index):
	#var tile_coordinates = Vector3(x, 0, z)  # Assuming a 2D grid, so Z-coordinate is 0
	#set_cell_item(tile_coordinates, tile_index)
