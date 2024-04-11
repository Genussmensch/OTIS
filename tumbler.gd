extends CharacterBody3D

var tumbler_health : float = 8
@onready var animated_sprite_3d = $Sprite
@export var move_speed = 2.0
@export var attack_range = 1.2
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var playerDamage = $World/Player
var dead = false
var damage  : int = 5

func _physics_process(delta):
	if dead:
		return
	if player == null:
		return
	var dir = player.global_position - global_position
	dir.y = 0.0
	dir = dir.normalized()
	
	velocity = dir * move_speed
	move_and_slide()
	attempt_to_kill_player()

func attempt_to_kill_player():
	var dist_to_player = global_position.distance_to(player.global_position)
	if dist_to_player > attack_range:
		return
	
	var eye_line = Vector3.UP * 1.5
	var query = PhysicsRayQueryParameters3D.create(global_position+eye_line, player.global_position+eye_line, 1)
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	if result.is_empty():
		player.takedamage(damage)

# Assuming 'health' is a variable declared elsewhere in your code

func takeDamage(playerDamage):
	# Deduct the player's health
	tumbler_health -= playerDamage
	$DamageSound.play()
	# Check if the player is dead
	if tumbler_health <= 0:
		dead = true
		$DeathSound.play()
		$Sprite.play("death")
		$Body.disabled = true
		
