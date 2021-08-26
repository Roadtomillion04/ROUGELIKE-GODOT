extends Node2D
class_name Items

onready var player = get_tree().current_scene.get_node("Player")

#var direction: Vector2 = Vector2.RIGHT.rotated(rand_range(0, PI*2))
var direction: Vector2 

var speed : int
var claimed : bool = false
var player_entered : bool = false

const POPUP_SCORE_SCENE = preload("res://Character/Damge/PopupDamage.tscn")

func _ready():
	randomize()
	speed = int(rand_range(20, 60))

func _physics_process(delta):
	if is_instance_valid(player):
		if (global_position - player.global_position).length() < 40:
		#yield(get_tree().create_timer(0.5), "timeout")
			player_entered = true
		
			if player_entered:
				#yield(get_tree().create_timer(0.4), "timeout")
				direction = global_position.direction_to(player.global_position).normalized()
				speed = int(lerp(speed, rand_range(20, 100), 0.2))


		else:
			#yield(get_tree().create_timer(0.6), "timeout")
			speed = int(lerp(speed, 0, 0.05))

		position += direction * speed * delta *2
		
#		if claimed:
#				var pop_up_damage = POPUP_SCORE_SCENE.instance() 
#				get_tree().current_scene.add_child(pop_up_damage)
##
#				pop_up_damage.start(Vector2(30, 10), global_position, -1, 12, str(name))
##
#				claimed = false


func splash_items(mouse_direction):
	#position = initial_pos
	direction = mouse_direction


func _on_Area2D_body_entered(body):
	body.ammo += 1
	get_tree().call_group("AmmoGUI", "_update_ammo", body.ammo)
	
	claimed = true
	queue_free()
	#body.update_items()
	


