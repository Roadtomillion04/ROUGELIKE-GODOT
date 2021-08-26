extends Items

func _on_Area2D_body_entered(body):
	body.ammo += 1
	get_tree().call_group("AmmoGUI", "_update_ammo", body.ammo)
	
	claimed = true
	queue_free()

