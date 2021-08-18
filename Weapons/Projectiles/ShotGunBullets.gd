extends Projectile

func _on_LifeTimer_timeout(): 
	direction = Vector2.ZERO
	animation_player.play("Hit_anim")
