extends Guns

func _process(_delta):
	
	var mouse_direction = (get_global_mouse_position() - global_position).normalized()
	
	if Input.is_action_pressed("ui_attack") and not weapon_changed and fire_delay_timer.is_stopped(): # only executes when stopped
		
		if name == "Spear":
			animation_player.play("SpearAnimation")
		
		fire_delay_timer.start(fire_rate)
		
		#for i in range(3):
		var projectile1 = PROJECTILE.instance()
		var projectile2 = PROJECTILE.instance()
		var projectile3 = PROJECTILE.instance()
		get_tree().current_scene.add_child(projectile1)
		get_tree().current_scene.add_child(projectile2)
		get_tree().current_scene.add_child(projectile3)
		
		projectile1.position = get_tree().current_scene.get_node("Player").position 
		projectile2.position = get_tree().current_scene.get_node("Player").position 
		projectile3.position = get_tree().current_scene.get_node("Player").position 
		
		#var rotation = mouse_direction.angle()
		
		projectile1.rotation_degrees = rotation_degrees
		projectile2.rotation_degrees = rotation_degrees
		projectile3.rotation_degrees = rotation_degrees
		
		projectile1.shot(projectile1.position, mouse_direction)
		projectile2.shot(projectile2.position, mouse_direction.rotated(-PI/6))
		projectile3.shot(projectile3.position, mouse_direction.rotated(PI/6))

		projectile3.life_time = 0.3
		
		
