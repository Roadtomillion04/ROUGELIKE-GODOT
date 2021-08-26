extends Projectile


func _process(delta):
	if is_instance_valid(Global.enemy):
		direction = global_position.direction_to(Global.enemy.global_position).normalized()
