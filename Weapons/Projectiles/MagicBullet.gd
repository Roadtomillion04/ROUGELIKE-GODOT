extends Projectile

func _on_Hitbox_body_entered(body):
	velocity = 0
	body.velocity = Vector2.ZERO
	animation_player.play("tripleattack")
	

func _on_WallsDetector_body_entered(_body):
	velocity = 0
	animation_player.play("tripleattack")
