extends CharacterBody3D

@export var attack_range = 1.5
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
var dist_to_player
var damage  : int = 50
var exploded : bool = false


func _process(delta):
	attempt_to_explode()
	
func attempt_to_explode():
	if exploded == false: 
		dist_to_player = global_position.distance_to(player.global_position)
		if dist_to_player < attack_range:
			player.takedamage(damage)
			$Sprite.play("death")
			$BOOM.play()
			exploded = true
