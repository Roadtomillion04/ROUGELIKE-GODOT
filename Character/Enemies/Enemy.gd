extends Character
class_name Enemy , "res://v1.1 dungeon crawler 16x16 pixel pack/enemies/flying creature/fly_anim_f0.png"

const ITEMS = preload("res://Itmes/HealthPotion.tscn")

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
		
		if distance_to_next_point < 1:
			path.remove(0)
			if not path:
				return
		move_diection = vector_to_next_point
			
			
		if vector_to_next_point.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
			
		elif vector_to_next_point.x < 0 and not animated_sprite.flip_h: 	animated_sprite.flip_h = true


func _on_PathTimer_timeout():
	if is_instance_valid(player):
		path = navigation.get_simple_path(global_position, player.global_position)
	
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
				var hp_potion = ITEMS.instance()
				get_tree().current_scene.add_child(hp_potion)
				hp_potion.position = global_position
				hp_potion.splash_items(Vector2.RIGHT.rotated(rand_range(0, PI*2)))

				
				item_spawnned = true
