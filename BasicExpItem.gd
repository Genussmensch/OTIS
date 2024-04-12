extends Node3D

@onready var direction = 0
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
@export var pickup_range = 1.0
var item_name : String = "Item"
var is_collectible : bool = true

func _process(_delta):
	attempt_to_pick_up()
	pass

func _ready():
	pass 
	
func attempt_to_pick_up():
	var dist_to_player = global_position.distance_to(player.global_position)
	if dist_to_player <= pickup_range:
		print("You collected: ", item_name)
		interact()
		return
func interact():
	if is_collectible:
		collect()
#

func collect():
	player.collect()
	queue_free() 
