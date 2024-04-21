extends CharacterBody3D

var health : float = 6
@onready var animated_sprite_3d = $Sprite
@export var move_speed = 3.0
@export var attack_range = 1.2
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var playerDamage = $World/Player
var dead = false
var damage  : int = 10

func _physics_process(delta):
	var dist_to_player = global_position.distance_to(player.global_position)
	if dist_to_player < 15:
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

func takeDamage(playerDamage):
	health -= playerDamage
	$DamageSound.play()
	if health <= 0:
		die()
	
func die():
	dead = true
	drop_item()
	$DeathSound.play()
	$Sprite.play("death")
	player.fevercount += 1000
	$Body.disabled = true
		
		
	
func drop_item():
# Random float between 0 and 1
	var random_value = randf()
	var scene_path
	if random_value < 0.4:  
		scene_path = load("res://BasicExpItem.tscn")
	elif random_value < 0.55:  
		scene_path = load("res://BasicAmmoItem.tscn")
	elif random_value < 0.6:  
		scene_path = load("res://BasicHealthItem.tscn")
	else:
		return 
	
	# Load and instantiate the chosen scene
	var item_instance = scene_path.instantiate()
	item_instance.global_position = self.global_position
	if get_parent():
		get_parent().add_child(item_instance)

