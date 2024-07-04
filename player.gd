extends CharacterBody3D

@onready var animated_sprite_2d = $Head/CanvasLayer/GunBase/AnimatedSprite2D
@onready var ray_cast_3d = $Head/RayCast3D
@onready var shoot_sound = $Head/ShootSound
@onready var click_sound = $Head/ClickSound

@onready var criticalChance = 0.1
@onready var defaultFactor : float = 1
@onready var temporaryFactor  : float = 1
@onready var criticalFactor  : float = 5
@onready var playerDamage  : float

@onready var head = $Head
@onready var mouse_sensitivity = float(0.3)
@onready var allFactors

var SPEED = 7.0
var speedFactor = 1

var level : int = 0
var health : int = 100
var ammo = 10
var dead = false
var can_shoot = true
var has_ammo = true
var knife_active :bool = false
var knife_range :float = 1.2
var isCooldownActive : bool = false
var cooldownTimer : float = 20

var fevercount  : int = 1
var breakthrough : int = 3000
var feveractive : bool = false
# Constants for fever effects
var defaultCriticalChance = 0.1
var defaultTemporaryFactor = 1
var defaultCriticalFactor = 5
var defaultSpeedFactor = 1

var exp : int = 0
var max_exp : int = 22

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	animated_sprite_2d.animation_finished.connect(shoot_anim_done)
	$Head/CanvasLayer/DeathScreen/Button.button_up.connect(restart)

func _input(event):
	if dead:
		return
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		head.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		
		
func _process(delta):
	feverStatus()
	if isCooldownActive:
		cooldownTimer -= 1
		if cooldownTimer <= 0:
			isCooldownActive = false
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		restart()
	if dead:
		return
	if Input.is_action_pressed("shoot"):
		shoot()
	if Input.is_action_pressed("stab"):
		stab()

func _physics_process(_delta):
	if dead:
		return
	var input_dir = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * speedFactor
		velocity.z = direction.z * SPEED * speedFactor
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * speedFactor)
		velocity.z = move_toward(velocity.z, 0, SPEED * speedFactor)
	
	move_and_slide()


func restart():
	get_tree().reload_current_scene()
	
	
func setup_knife():
	knife_active = true
	animated_sprite_2d.play("knife")
		
func stab():
	animated_sprite_2d.play("stab")
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("takeDamage"):
		if global_position.distance_to(ray_cast_3d.get_collider().global_position) <= knife_range:
			if ray_cast_3d.get_collider().is_in_group("Enemy"):
				playerDamage = getAllDamageFactors()
				ray_cast_3d.get_collider().takeDamage(playerDamage)
			
func shoot():
	if !can_shoot:
		return
	if !has_ammo:
		if knife_active == false:
			click_sound.play()
			return
	can_shoot = false
	animated_sprite_2d.play("shoot")
	shoot_sound.play()
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("takeDamage"):
		if ray_cast_3d.get_collider().is_in_group("Enemy"):
			playerDamage = getAllDamageFactors()
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
		cooldownTimer = 20
		isCooldownActive = true
	if health <= 0 :
		kill()
		
func getAllDamageFactors():
	#prüfe Waffe und Buffs
	var randomValue = randf()
	var critical
	if randomValue < criticalChance:
		critical = criticalFactor
		$CRITICAL.play() 
	else:
		critical = 1
	allFactors = critical * defaultFactor * temporaryFactor
	return allFactors
	
	
func feverStatus():
	# Check if fever should be activated
	if fevercount >= breakthrough:
		if not feveractive:
			#fever()
			return
	else:
		if feveractive:
			endFever()
			
func fever():
	# Activate fever effects

	$FEVER.play()
	feveractive = true
	criticalChance = 0.3
	temporaryFactor = 2
	criticalFactor = 10
	speedFactor += 1.5

func endFever():
	# Deactivate fever effects
	
	$FEVER.stop()  # Stop the fever sound
	feveractive = false
	criticalChance = defaultCriticalChance
	temporaryFactor = defaultTemporaryFactor
	criticalFactor = defaultCriticalFactor
	speedFactor = defaultSpeedFactor

func _on_music_finished():
	# Replay fever sound when associated music finishes
	print('f2')
	$FEVER.play()

func kill():
	dead = true
	$Head/CanvasLayer/DeathScreen.show()
	$Head/CanvasLayer/DeathScreen/Haeger.play()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func get_ammo():
	return ammo
	
func collect():
	$COLLECT.play()
	
func level_up():
	$Head/CanvasLayer/LEVELUP.play("levelup")
	$LEVELUP.play()
	level = level + 1
	SPEED += 0.2
	
	
	
