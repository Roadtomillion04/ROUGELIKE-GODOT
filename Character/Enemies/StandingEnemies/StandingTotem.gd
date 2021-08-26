extends Enemy

const BULLET = preload("res://Weapons/Projectiles/EnemyProjectiles/EnemyProjectile.tscn")

func _ready():
	$ShootTimeout.wait_time = 4
	randomize()

func _process(_delta):
	#var bullet = BULLET.instance()
	if $ShootTimeout.is_stopped():
		shoot(Vector2.DOWN)
		shoot(Vector2.UP)
		shoot(Vector2.RIGHT)
		shoot(Vector2.LEFT)
		#bullet.velocity = lerp(velocity, 0, 1)
		$ShootTimeout.start(rand_range(1, 7))
#	yield(get_tree().create_timer(1), "timeout")

func shoot(dir):
	if is_instance_valid(player):
		var bullet = BULLET.instance()
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)
	
		#var dir = bullet.global_position.direction_to(player.global_position).normalized()

		bullet.direction = dir
		
		var scale_value = rand_range(0.5, 1.5)
		
		bullet.scale = Vector2(scale_value, scale_value) 



