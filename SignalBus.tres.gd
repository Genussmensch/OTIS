extends Node

# Called when the node enters the scene tree for the first time.
signal _exit()
func on_exit():
	
	get_tree().change_scene_to_file("res://Presentation Level2.tscn")
