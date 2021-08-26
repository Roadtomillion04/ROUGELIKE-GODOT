extends KinematicBody2D
class_name Character, "res://v1.1 dungeon crawler 16x16 pixel pack/heroes/knight/knight_idle_anim_f0.png"

var armor_broken : bool = false

const POPUP_SCORE_SCENE = preload("res://Character/Damge/PopupDamage.tscn")

export(int) var hp:int = 4 setget set_hp
var max_hp : int
export(int) var armor_hp : int = 4 setget set_armor_hp

signal hp_changed(new_hp)
signal armor_hp_changed(new_hp)
signal update_hp_items(hp)

export(float) var heavy_knockback:float = 2.15

onready var state_machine = get_node("FiniteStateMachine")
onready var animated_sprite = get_node("AnimatedSprite")
onready var health_timer = get_node("HealthTimer")

const FRICTION:float = 0.15

export(int) var acceleration:int = 40
export(int) var max_speed:int = 100

var move_diection = Vector2.ZERO
var velocity = Vector2.ZERO

func _ready():
	max_hp = hp

func _physics_process(_delta):
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)

func move():
	move_diection = move_diection.normalized()
	velocity += move_diection * acceleration
	velocity = velocity.clamped(max_speed)


func take_damage(dam, dir, force):
	var pop_up_damage = POPUP_SCORE_SCENE.instance() 
	get_tree().current_scene.add_child(pop_up_damage)
	
	if state_machine.state != state_machine.states.dead:
	
		if armor_broken:
			self.hp -= dam
		
		else:
			self.armor_hp -= dam
			
		if hp > 0 or armor_hp > 0:
			state_machine.set_state(state_machine.states.hurt)
			velocity += dir * force
			health_timer.start()
			Global.camera.screen_shake(30, 0.01)
			
			#popup
			pop_up_damage.start(Vector2(30, 10), global_position, -1, 12, "-" + str(dam))
			
			#framefreeze
	#		framefreeze(0.1, 0.4)
		
		else:
			state_machine.set_state(state_machine.states.dead)
			velocity += dir * force * heavy_knockback
			Global.camera.screen_shake(60, 0.01)
			
			pop_up_damage.start(Vector2(30, 10), global_position, -1, 30, "K.O")
			
			

func framefreeze(time_scale, duration):
	Engine.time_scale = time_scale
	yield(get_tree().create_timer(duration * time_scale), "timeout")
	Engine.time_scale = 1


func poison_inflicted(num_of_times: int):
	modulate = Color(0.1, 1, 0.1, 1)
	while num_of_times > 0:
		yield(get_tree().create_timer(2), "timeout")
		take_damage(1, Vector2.ZERO, 0)
		num_of_times -= 1
		continue
	modulate = Color(1, 1, 1, 1)


func set_hp(new_hp : int):
	hp = new_hp
	emit_signal("hp_changed", new_hp)

func set_armor_hp(new_hp : int):
	armor_hp = new_hp
	emit_signal("armor_hp_changed", new_hp)
	
	if new_hp <= 0:
		armor_broken = true


func _on_HealthTimer_timeout():
	pass

func update_health():
	if hp < max_hp:
		hp = int(clamp(hp + 1, 1, 4))
		emit_signal("update_hp_items", hp)
