extends GridMap
var tilemap2D : TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	create_3d_layout()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func create_3d_layout():
	for x in range(tilemap2D.get_width()):
		for y in range(tilemap2D.get_height()):
			# Get the cell data from the 2D tilemap
			var cell_value = tilemap2D.get_cell(x, y)
			
			# Create corresponding 3D objects based on the cell_value
			if cell_value != -1:  # Assuming -1 means an empty tile
				var instance = preload("res://path/to/3d_object.tscn").instance()
				var transform = Transform3D()
				transform.origin = Vector3(x * 2, 0, y * 2) 
				 # Adjust the scale factor as needed
				instance.transform = transform
				add_child(instance)
				set_cell_item(x, 0, y, instance)
