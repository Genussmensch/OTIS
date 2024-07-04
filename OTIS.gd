extends Control
@onready var background = $Background
@onready var music =$music
func _ready():
	music.play()
	$VBoxContainer/Start.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Levels.tscn")


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://Presentation Level1.tscn")


func _on_exit_pressed():
	get_tree().quit()
