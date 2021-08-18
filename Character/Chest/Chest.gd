extends StaticBody2D

export(PackedScene) var GUN 

var can_click : bool = false
var picked_gun

onready var animation_player = get_node("AnimationPlayer")

func _ready():
	pass
#	GUN.shuffle()
#	GUN.pop_front()
#
#	for gun in GUN:
#		picked_gun = gun

func _on_PlayerDetect_body_entered(_body):
	can_click = true


func _on_PlayerDetect_body_exited(_body):
	can_click = false


func _process(_delta):
	if Input.is_action_pressed("ui_accept") and can_click:
		open()
		can_click = false
		
func open():
	animation_player.play("Open")
	get_tree().call_group("WeaponManager", "drop_weapon", GUN)


