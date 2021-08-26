extends Items

func _on_Area2D_body_entered(body):
	if not body.has_node("PASS_KEY"):
		body._on_pass_key_claimed()
	
	claimed = true
	queue_free()
