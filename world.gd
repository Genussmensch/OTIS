extends Node3D
@onready var music =$music

# Called when the node enters the scene tree for the first time.
func _ready():
	music.play()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
