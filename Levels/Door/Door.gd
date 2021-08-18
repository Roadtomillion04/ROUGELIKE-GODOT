extends StaticBody2D

onready var animation_player = get_node("AnimationPlayer")

func open():
	animation_player.play("door_open")
