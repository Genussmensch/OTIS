extends AnimatedSprite2D

@onready var scaled_exp: int = 0
@onready var scaled_exp_frame: int = 0
var exp_scale: int = 22
var exp_render_scale: float = 0.0
var is_dead: bool = false
@onready var unscaled_exp  : int
@onready var unscaled_max_exp : int = get_parent().get_parent().get_parent().max_exp
func _ready():
	exp_render_scale = exp_scale / unscaled_max_exp
	
func _process(delta):
	render_expbar()

func render_expbar():
	unscaled_exp = get_parent().get_parent().get_parent().exp 
	var h = unscaled_exp * exp_render_scale
	scaled_exp = ceil(h)
	set_frame(scaled_exp)

