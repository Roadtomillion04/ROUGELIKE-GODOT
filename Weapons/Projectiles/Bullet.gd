extends Projectile


#func _process(delta):
#	lerp(velocity, 0, 1)

func _on_LifeTimer_timeout():
	queue_free()
