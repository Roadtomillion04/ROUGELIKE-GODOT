extends Projectile


func _on_LifeTimer_timeout():
	if hitbox.collision_mask == 1 or hitbox.collision_mask == 4: 
		direction = Vector2.ZERO
		animation_player.play("Explode")

func _on_WallsDetector_body_entered(_body):
	velocity = 0
	animation_player.play("Explode")
