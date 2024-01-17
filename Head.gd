extends Node3D

var rotation_speed = 0.1
var maxup = 90
var maxdown = -90

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get input for camera movement (you may replace this with your own input handling)
	var rotation_input = -Input.get_action_strength("ui_right") + Input.get_action_strength("ui_left")
	var pitch_input = -Input.get_action_strength("ui_up") + Input.get_action_strength("ui_down")

	# Rotate the node (container) based on input
	rotate_y(rotation_input * rotation_speed)
	rotate_x(pitch_input * rotation_speed)

	# Clamp the pitch angle to prevent over-rotation
	var current_pitch = get_rotation_degrees().x
	current_pitch = clamp(current_pitch, maxdown, maxup)
	set_rotation_degrees(Vector3(current_pitch, 0, 0))
