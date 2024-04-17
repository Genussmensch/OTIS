extends AnimatedSprite2D

@onready var ammo : float = get_parent().get_parent().get_parent().ammo
var ammo_max: float = 32
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	render_ammobar()

func render_ammobar():
	ammo = get_parent().get_parent().get_parent().ammo 
	if ammo > ammo_max:
		ammo = ammo_max
	set_frame(ammo)

