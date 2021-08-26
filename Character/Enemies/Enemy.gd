extends Character
class_name Enemy , "res://v1.1 dungeon crawler 16x16 pixel pack/enemies/flying creature/fly_anim_f0.png"

const AMMO = preload("res://Itmes/BulletAmmo.tscn")
const PASS_KEY = preload("res://Itmes/PassKey.tscn")

const BLOOD = preload("res://Character/Enemies/Blood.tscn")

var path: PoolVector2Array

onready var navigation = get_tree().current_scene.get_node("Rooms")
onready var player = get_tree().current_scene.get_node("Player")
onready var path_timer = get_node("PathTimer")

var item_spawnned : bool = false

func chase():
	if path:
		var vector_to_next_point = path[0] - global_position
		var distance_to_next_point = vector_to_next_point.length()
		
		if distance_to_next_point < 3:
			path.remove(0)
			if not path:
				return
		move_diection = vector_to_next_point
			
			
		if vector_to_next_point.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
			
		elif vector_to_next_point.x < 0 and not animated_sprite.flip_h: 	animated_sprite.flip_h = true


func _on_PathTimer_timeout():
	if is_instance_valid(player):
		_get_path_to_player()
	else:
		path_timer.stop()
		path = []
		move_diection = Vector2.ZERO


func _ready():
	randomize()

func _process(_delta):
	#var mouse_direction = (get_global_mouse_position() - global_position).normalized()
	
	if hp <= 0:
#		var blood = BLOOD.instance()
#		get_tree().current_scene.add_child(blood)
#		blood.position = global_position
#		blood.rotation = position.angle_to_point(player.global_position)

		if not item_spawnned :
			var no_of_items: int = 4
			while no_of_items > 0:
				var bullet_ammo
				if randi() % 2 == 0:
					bullet_ammo = AMMO.instance()
				else:
					bullet_ammo = PASS_KEY.instance()
				get_tree().current_scene.add_child(bullet_ammo)
				bullet_ammo.position = global_position
				bullet_ammo.splash_items(Vector2.RIGHT.rotated(rand_range(0, PI*2)))

				item_spawnned = true
				no_of_items -= 1


func _get_path_to_player():
	path = navigation.get_simple_path(global_position, player.global_position)
	
