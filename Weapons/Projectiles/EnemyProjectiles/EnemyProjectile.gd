extends Projectile


func _ready():
	randomize()

func _process(_delta):
	velocity = float(lerp(velocity, rand_range(40, 80), rand_range(0.03, 0.1)))
	#direction = global_position.direction_to(player.global_position)

func _on_LifeTimer_timeout():
	direction = Vector2.ZERO
	queue_free()
	print("died")

func _on_WallsDetector_body_entered(_body):
	direction = Vector2.ZERO
	velocity = 0
	animation_player.play("Hit_anim")
