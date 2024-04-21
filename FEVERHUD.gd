extends AnimatedSprite2D
@onready var fevercount 
@onready var breakthrough 
@onready var feveractive 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	update()
	


func update():
	
	feveractive = get_parent().get_parent().get_parent().feveractive
	# Determine which animation to play based on feveractive state
	if feveractive:
		# If feveractive is true, play "feveractive" animation
		play("feveractive")
	else:
		# If feveractive is false, play "idle" animation
		play("idle")
