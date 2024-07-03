extends Node3D

signal _exit()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func on_exit():
	load_next_level()
	
	
func load_next_level():
	get_tree().change_scene_to_file("res://Presentation Level 2.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
