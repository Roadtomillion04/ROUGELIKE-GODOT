extends Control

onready var animation_player = get_node("AnimationPlayer")
onready var player = get_tree().current_scene.get_node("Player")



func _on_StartButton_pressed():
	Global.change_scene("res://Levels/TempateLevel.tscn", animation_player)


func _on_LoadButton_pressed():
	Global.load_data()
	Global.change_scene("res://Levels/TempateLevel.tscn", animation_player)

	#player.global_position = Global.save_data.Position
	#player.hp = Global.save_data.PlayerHp

func _on_QuitButton_pressed():
	get_tree().quit()
