extends CharacterBody3D

@export var attack_range = 1.2
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
var damage  : int = 50
var exploded : bool = false
func _physics_process(delta):
	attempt_to_explode()
	
	
	
func attempt_to_explode():
	if exploded == false: 
		var dist_to_player = global_position.distance_to(player.global_position)
		if dist_to_player > attack_range:
			return
		var eye_line = Vector3.UP * 1.5
		var query = PhysicsRayQueryParameters3D.create(global_position+eye_line, player.global_position+eye_line, 1)
		var result = get_world_3d().direct_space_state.intersect_ray(query)
		if result.is_empty():
			player.takedamage(damage)
			$Sprite.play("death")
			$BOOM.play()
			exploded = true
