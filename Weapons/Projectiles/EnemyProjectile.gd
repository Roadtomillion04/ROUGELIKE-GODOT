extends Projectile

func _ready():
	randomize()

func _process(_delta):
	velocity = float(lerp(velocity, 70, 0.03))

func _on_LifeTimer_timeout():
	direction = Vector2.ZERO
	queue_free()
	print("died")

func _on_WallsDetector_body_entered(_body):
	direction = Vector2.ZERO
	velocity = 0
	animation_player.play("Hit_anim")
