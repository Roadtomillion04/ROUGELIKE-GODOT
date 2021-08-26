extends Control

onready var player = get_tree().current_scene.get_node("Player")

func _unhandled_input(_event):
	if Input.is_action_just_pressed("Esc"):
		change_display()


func _on_SaveButton_pressed():
	Global.player_data(player.global_position, player.hp, player.armor_hp)
	Global.save_current_data()
	change_display()


func _on_LoadButton_pressed():
	Global.load_data()
	player.global_position = Global.save_data.Position
	player.hp = Global.save_data.PlayerHp
	player.armor_hp = Global.save_data.PlayerArmorHp

	change_display()

func change_display():
	get_tree().paused = !get_tree().paused
	visible = !visible
