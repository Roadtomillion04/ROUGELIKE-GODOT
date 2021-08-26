extends Node

var num_of_enemies 

const SPAWN_EXPLOSION = preload("res://Character/Enemies/SpawnExplosion.tscn")

const ENEMIES_SCENE = {
	"FLYING_CREATURE": preload("res://Character/Enemies/FlyingCreature/FlyingCreature.tscn"),
	"SLIME": preload("res://Character/Enemies/Slime/ Slime.tscn"),
	"GOBLIN": preload("res://Character/Enemies/Goblin/Goblin.tscn"),
	"TOTEM": preload("res://Character/Enemies/StandingEnemies/StandingTotem.tscn")
	
}




onready var player = get_tree().current_scene.get_node("Player")
onready var tilemap = $TileMap
onready var floor_tilemap = $TileMap2
onready var entrance = $Entrance
onready var door_container = $Doors
onready var enemy_container = $EnemyPositions
onready var enemy_node = get_node("Enemies")
onready var player_detector = get_node("PlayerDetector")

func _ready():
	num_of_enemies = enemy_container.get_child_count()
	randomize()


func _open_doors():
	for door in door_container.get_children():
		door.open()


func _close_entrance(tile_id1: int, tile_id2: int):
	for entry_position in entrance.get_children():
		tilemap.set_cellv(tilemap.world_to_map(entry_position.position), tile_id1)
		tilemap.set_cellv(tilemap.world_to_map(entry_position.position) + Vector2.DOWN, tile_id2)


func spawn_enemies():
#	var tilemap_rect = floor_tilemap.get_used_rect()
#	var tilemap_start_position = tilemap_rect.position
#	var tilemap_size = tilemap_rect.size
#	var x = rand_range(tilemap_start_position.x + 16, tilemap_start_position.x + tilemap_size.x - 16)
#	var y = rand_range(tilemap_start_position.y + 32, tilemap_start_position.y + tilemap_size.y - 16)
	
	for enemy_position in enemy_container.get_children():
		var enemy
		
		if randi() % 2:
			enemy = ENEMIES_SCENE.FLYING_CREATURE.instance()
		else:
			enemy = ENEMIES_SCENE.GOBLIN.instance()

		enemy.connect("tree_exited", self, "_on_enemies_killed")
		enemy.position = enemy_position.position 
		get_node("Enemies").call_deferred("add_child", enemy)
	
	#spawn explosion
		var spawn_explosion = SPAWN_EXPLOSION.instance()
		spawn_explosion.position = enemy.position
		call_deferred("add_child", spawn_explosion)


func _on_enemies_killed():
	num_of_enemies -= 1
	
	if num_of_enemies == 1:
		get_node("Enemies")._on_last_enemy()

	elif num_of_enemies == 0:
		_open_doors()
		_close_entrance(-1, -1) # -1 clears the tile
		#Global.camera.screen_shake(300, 1)


func kill_all_enemies():
	for child in enemy_node.get_children():
		if child is KinematicBody2D:
			yield(get_tree().create_timer(1), "timeout")
			child.queue_free()
			#child.queue_free()

func _on_PlayerDetector_body_exited(_body):
	player_detector.queue_free()
	
	if num_of_enemies > 0:
		_close_entrance(6, 7)
		spawn_enemies()

	else:
		_open_doors()


