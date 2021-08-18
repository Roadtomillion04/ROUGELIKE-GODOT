extends Area2D

onready var player = get_tree().current_scene.get_node("Player")

#var direction: Vector2 = Vector2.RIGHT.rotated(rand_range(0, PI*2))
var direction: Vector2 

export(int) var speed : int = 50
var claimed : bool = false
var player_entered : bool = false

const POPUP_SCORE_SCENE = preload("res://Character/Damge/PopupDamage.gd")

func _ready():
	randomize()

func _physics_process(delta):
	
	if (global_position - player.global_position).length() < 40 :
		#yield(get_tree().create_timer(0.5), "timeout")
		player_entered = true
		
		if player_entered:
			direction = global_position.direction_to(player.global_position).normalized()
			speed = lerp(speed, 100, 0.2)


	else:	
		speed = lerp(speed, 0, 0.05)
		
	position += direction * speed * delta * 2
		
#		if claimed:
#				var pop_up_damage = POPUP_SCORE_SCENE.instance() 
#				get_tree().current_scene.add_child(pop_up_damage)
#
#				pop_up_damage.start(Vector2(30, 10), global_position, -1, 12, str(name))
#
#				claimed = false


func splash_items(mouse_direction):
	#position = initial_pos
	direction = mouse_direction

	

func _on_HealthPotion_body_entered(body):
	
	queue_free()
	body.update_items()
	
	claimed = true

