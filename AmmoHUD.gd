extends Label

func _ready():
	pass
func _process(delta):
	var ammo = get_parent().get_parent().get_parent().ammo
	var health = get_parent().get_parent().get_parent().health
	var fevercount = get_parent().get_parent().get_parent().fevercount
	var feveractive = get_parent().get_parent().get_parent().feveractive
	text = "Ammo: "+str(ammo)+"
	Health: "+str(health)+"
	fevercount: "+str(fevercount)+"
	Fever? "+str(feveractive)
	


