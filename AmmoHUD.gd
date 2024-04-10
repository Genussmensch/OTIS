extends Label

func _ready():
	pass
func _process(delta):
	var ammo = get_parent().get_parent().get_parent().ammo
	var health = get_parent().get_parent().get_parent().health
	
	
	text = "Ammo: "+str(ammo)+"
	Health: "+str(health)
	


