extends StaticBody2D

onready var animation_player = get_node("AnimationPlayer")

func open():
	animation_player.play("door_open")

func open_for_key():
	animation_player.play("KEY_OPEN")

func _on_Area2D_body_entered(body):
	if body.has_node("PASS_KEY"):
		open_for_key()
		body.get_node("PASS_KEY").queue_free()
		
		get_tree().call_group("Room", "kill_all_enemies")
