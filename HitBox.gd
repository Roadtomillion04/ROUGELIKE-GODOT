extends Area2D
class_name HitBox

var default_crit_rate : float = 0

export(int) var damage : int = 1
var knockback_direction : Vector2 = Vector2.ZERO
export(int) var knockback_force : int = 300
var crit_rate : float 
export(bool) var can_do_crit : bool = false

onready var collision_shape = get_child(0)

const POPUP_SCORE_SCENE = preload("res://Character/Damge/PopupDamage.tscn")


func _init():
	var __ = connect("body_entered", self, "_on_body_entered")
	var ___ = connect("body_exited", self, "_on_body_exited")

func _ready():
	randomize()
	crit_rate = randf()
	#print(crit_rate)
	assert(collision_shape != null)

func _on_body_entered(body):
	var pop_up_damage = POPUP_SCORE_SCENE.instance() 
	get_tree().current_scene.add_child(pop_up_damage)
	
	if can_do_crit and crit_rate > 0.8:
		body.take_damage(damage * 2, knockback_direction, knockback_force)
		
		body.framefreeze(0.5, 0.4)
		
		pop_up_damage.start(Vector2(50, 21), global_position, 1, 22, "CRITICAL")
		Global.camera.screen_shake(100, 0.01)
	
	else:
		body.take_damage(damage, knockback_direction, knockback_force)


func _on_body_exited(_body):
	pass
