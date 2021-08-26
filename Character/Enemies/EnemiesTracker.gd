extends Node



func _ready():
	pass
	#for enemy in get_children():
		#enemy.connect("tree_exited", self, "enemies_left")
	

func _on_last_enemy():
	var last_enemy = get_child(0)
#	last_enemy.angry_sprite.visible = true
#	last_enemy.modulate = Color(1, 0.2, 0.3, 1)
#	last_enemy.hitbox.damage = 2



