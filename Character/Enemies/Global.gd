extends Node

var camera = null

var pos: Vector2

var save_file_exits: bool

var save_game_file_path: String = "user://playerData.txt"
var save_data: Dictionary = {
	"Position": null,
	"PlayerHp": int(4),
	"PlayerArmorHp": int(4)
}


func change_scene(path, animation_player, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("Fade in and out")
	yield(animation_player, "animation_finished")
	var __ = get_tree().change_scene(path)


func player_data(position: Vector2, hp: int, armor_hp:int):
	save_data["Position"] = position
	save_data["PlayerHp"] = hp
	save_data.PlayerArmorHp = armor_hp
	
	print(save_data)


func save_current_data():
	var save_file = File.new()
	save_file.open(save_game_file_path, File.WRITE)
	#save_file.store_line(to_json(save_data))
	save_file.store_var(save_data)
	save_file.close()


func load_data():
	var data_file = File.new()
	
	if not data_file.file_exists(save_game_file_path):
		save_file_exits = false
		return
	
	data_file.open(save_game_file_path, File.READ)
	
	save_data = data_file.get_var()
	
	player_data(save_data.Position, save_data.PlayerHp, save_data.PlayerArmorHp)
	
	#loop through file line by line
	#while data_file.get_position() < data_file.get_len():
		#var loaded_data = parse_json(data_file.get_line())

		#grab save data
		#save_data.Position = loaded_data["Position"]
		#ave_data.PlayerHp = loaded_data["PlayerHp"]

	data_file.close()
