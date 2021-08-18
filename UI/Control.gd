extends Control

func _unhandled_input(_event):
	if Input.is_action_just_pressed("Esc"):
		get_tree().paused = !get_tree().paused
		visible = !visible
		get_parent().get_node("ArmorBar").visible = !get_parent().get_node("ArmorBar").visible
		
		
		#get_parent().get_node("HealthBar").visible = !get_parent().get_node("HealthBar").visible

		#get_parent().get_node("HealthBar").rect_position = Vector2(200, 50) 

