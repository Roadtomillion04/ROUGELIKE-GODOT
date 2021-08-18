extends Projectile

func _ready():
	randomize()

func _process(_delta):
	velocity = float(clamp(velocity + 5, velocity, velocity*2))


func _on_Hitbox_body_entered(body):
	velocity = 0
	animation_player.play("fade")
	if randi() % 4 == 0:
		body.poison_inflicted(3)
	

func _on_WallsDetector_body_entered(_body):
	velocity = 0
	animation_player.play("fade")
