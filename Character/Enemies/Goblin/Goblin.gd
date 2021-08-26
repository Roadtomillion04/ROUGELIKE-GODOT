extends Enemy

const KNIFE = preload("res://Weapons/Projectiles/EnemyProjectiles/GoblinKnife.tscn")

const MAX_DISTANCE_TO_PLAYER: int = 80
const MIN_DISTANCE_TO_PLAYER: int = 50

var distance_to_player: float

onready var shoot_timer = get_node("ShootTimer")
onready var aim_raycast = get_node("AimRaycast")

func _on_PathTimer_timeout():
	if is_instance_valid(player):
		distance_to_player = (player.global_position - global_position).length()

		if distance_to_player > MAX_DISTANCE_TO_PLAYER:
			_get_path_to_player()
		elif distance_to_player < MIN_DISTANCE_TO_PLAYER:
			_get_path_to_move_away_from_player()

	else:
		path_timer.stop()
		path = []
		move_diection = Vector2.ZERO


func _get_path_to_move_away_from_player():
	var dir: Vector2 = (global_position - player.global_position).normalized()
	
	path = navigation.get_simple_path(global_position, global_position + dir * 100)


func _ready():
	randomize()
	shoot_timer.wait_time = 0.5


func _process(_delta):
	if shoot_timer.is_stopped() and state_machine.state == state_machine.states.idle:
		shoot()
		shoot_timer.start(rand_range(1.1, 3.2))


func shoot():
	aim_raycast.cast_to = player.global_position - global_position

	if is_instance_valid(player) and not aim_raycast.is_colliding():
		var knife = KNIFE.instance()
		knife.global_position = global_position
		get_tree().current_scene.add_child(knife)
	
		var dir = (player.global_position - knife.global_position).normalized()
		
		knife.shot(global_position, dir)

