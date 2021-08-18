extends ItemList

onready var player = get_tree().current_scene.get_node("Player")

func update_items(no_of_items):
	clear()
	
	for _items in range(no_of_items):
		add_icon_item(load("res://v1.1 dungeon crawler 16x16 pixel pack/props_itens/potion_green.png"), true)


func _on_ItemList_item_selected(index):
	if player.hp < player.max_hp:
		get_tree().call_group("Player", "update_health")
		remove_item(index)
		get_tree().call_group("Player", "item_used")
	
	else:
		yield(get_tree().create_timer(1), "timeout")
		unselect(index)
		
