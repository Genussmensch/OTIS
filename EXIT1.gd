extends CharacterBody3D
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
var dist_to_player

var current_scene = null
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func _process(delta):
	attempt_to_exit()
	
func attempt_to_exit():
		dist_to_player = global_position.distance_to(player.global_position)
		if dist_to_player < 2:
			exit()
		
func exit():
	print("PlayerIsExiting")
	SignalBus.emit_signal("_exit")
	#var res_path = "res://DemoP1.tscn"
	#switch_scene(res_path)
		

func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)
	
func _deferred_switch_scene(res_path):
	current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

