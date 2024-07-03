extends Node2D

# Called when the node enters the scene tree for the first time.
func getTileMap() -> TileMap:
	var child = find_child("TileMap")
	if child is TileMap:
		return child as TileMap
	return null
func _ready():
	var h = getTileMap()
	if h:
		var coords = [
			Vector2(0, 0),
			Vector2(10, 10),
		]
		var pattern = h.get_pattern(0, coords)
		for cell in h.get_used_cells(0):
			var atlasCoords = h.get_cell_atlas_coords(0, cell)
			var sourceId = h.get_cell_source_id(0, cell)
			for x in range(0, 10):
				for y in range(0, 10):
					h.set_cell(0, cell + Vector2i(x * 9, y * 9), sourceId, atlasCoords)	
			print(h.get_cell_atlas_coords(0, cell))
	h.queue_redraw()
	print(h)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


