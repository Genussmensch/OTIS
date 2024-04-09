extends CharacterBody3D

@onready var animated_sprite_2d = $Head/CanvasLayer/GunBase/AnimatedSprite2D
@onready var ray_cast_3d = $Head/RayCast3D
@onready var shoot_sound = $Head/ShootSound
@onready var click_sound = $Head/ClickSound
@onready var playerDamage = 50
@onready var head = $Head
@onready var mouse_sensitivity = float(0.3)

const SPEED = 5.0
var health : int = 100
var can_shoot = true
var dead = false
var ammo = 20
var has_ammo = true

var isCooldownActive : bool = false
var cooldownTimer : float = 0.0


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	animated_sprite_2d.animation_finished.connect(shoot_anim_done)
	$Head/CanvasLayer/DeathScreen/Panel/Button.button_up.connect(restart)

func _input(event):
	if dead:
		return
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		head.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		
		
func _process(delta):
	if isCooldownActive:
		cooldownTimer -= delta
		if cooldownTimer <= 0:
			isCooldownActive = false
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		restart()
	if dead:
		return
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(_delta):
	if dead:
		return
	var input_dir = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()


func restart():
	get_tree().reload_current_scene()

func shoot():
	if !can_shoot:
		return
	if !has_ammo:
		click_sound.play()
		return
	can_shoot = false
	animated_sprite_2d.play("shoot")
	shoot_sound.play()
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("takeDamage"):
		ray_cast_3d.get_collider().takeDamage(playerDamage)
	ammocount()

func shoot_anim_done():
	can_shoot = true
func ammocount():
	if ammo > 1:
		ammo -= 1
	else:
		ammo = 0
		has_ammo = false
		
func takedamage(damage : int):
	if not isCooldownActive:
		health -= damage
		# Set the cooldown timer to one second
		var cooldownTimer : float = 0.5
		isCooldownActive = true
		# Additional logic or actions can be added here based on the damage taken
	else:
		print("Cooldown active. Cannot take damage right now.")
	if health == 0 :
		kill()

func kill():
	dead = true
	$Head/CanvasLayer/DeathScreen.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func get_ammo():
	return ammo
