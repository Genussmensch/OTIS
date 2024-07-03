extends CharacterBody3D


@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")

var dist_to_player


func _process(delta):
	attempt_to_exit()
	
func attempt_to_exit():
		dist_to_player = global_position.distance_to(player.global_position)
		if dist_to_player < 2:
			get_tree().change_scene_to_file("res://Presentation Level 4.tscn")
	
