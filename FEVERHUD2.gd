extends AnimatedSprite2D

@onready var scaled_fever: int = 0
@onready var scaled_fever_frame: int = 0
@onready var unscaled_fever = get_parent().get_parent().get_parent().fevercount
@onready var breakthrough = get_parent().get_parent().get_parent().breakthrough 
var fever_scale: float = 118
var fever_render_scale: float = 0.0


var feveractive
# Called when the node enters the scene tree for the first time.
func _ready():
	fever_render_scale = fever_scale / breakthrough
	print(unscaled_fever)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()

func update():
	unscaled_fever = get_parent().get_parent().get_parent().fevercount
	feveractive = get_parent().get_parent().get_parent().feveractive
	var h = unscaled_fever * fever_render_scale
	scaled_fever = ceil(h)
	
	if !feveractive:
		scaled_fever_frame = int(fever_scale - scaled_fever) 
		set_frame(scaled_fever_frame)
	else:
		set_frame(scaled_fever)
		
	
