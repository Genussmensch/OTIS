extends GridMap


var tilemap2D : TileMap

func _ready():
	# Assuming the tilemap2D is set in the inspector
	create_3d_layout()

func create_3d_layout():
	for x in range(tilemap2D.get_width()):
		for y in range(tilemap2D.get_height()):
			# Get the cell data from the 2D tilemap
			var cell_value = tilemap2D.get_cell(x, y)
			
			# Create corresponding 3D objects based on the cell_value
			if cell_value != -1:  # Assuming -1 means an empty tile
				var instance = preload("res://MapGen.tscn").instance()
				var transform = Transform3D()
				transform.origin = Vector3(x * 2, 0, y * 2)  # Adjust the scale factor as needed
				instance.transform = transform
				add_child(instance)
				set_cell_item(instance, 0, 2)

#Adjust the script based on the structure of your 3D objects and the logic for mapping 2D tiles to 3D objects. This is a basic example, and you may need to consider factors such as tile rotation, scaling, or using different 3D objects based on the tile value.
