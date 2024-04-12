extends Node  

@onready var scaled_health: int = 0
@onready var scaled_health_frame: int = 0
var health_scale: float = 16
var health_render_scale: float = 0.0
var is_dead: bool = false
@onready var unscaled_health : float = get_parent().health

func _ready():
	health_render_scale = health_scale / unscaled_health
	
func _process(delta):
	render_healthbar()

func render_healthbar():
	unscaled_health = get_parent().health if "health" in get_parent() else unscaled_health
	is_dead = get_parent().dead if "dead" in get_parent() else is_dead
	var h = unscaled_health * health_render_scale
	scaled_health = ceil(h)
	scaled_health_frame = int(health_scale - scaled_health) 
	$healthbar.set_frame(scaled_health_frame)
	if is_dead:
		queue_free()  
