extends CanvasLayer

const MIN_HEALTH : int = 23

var max_hp : int = 4
var can_heal_armor: bool = true
var armor_hp : int = 4

onready var player = get_parent().get_node("Player")
onready var health_bar = get_node("HealthBar")
onready var armor_bar = get_node("ArmorBar")
onready var health_bar_tween = get_node("HealthBar/Tween")
onready var armor_bar_tween = get_node("ArmorBar/Tween")

func _ready():
	max_hp = player.hp
	update_helath_bar(100, "Health")
	update_helath_bar(100, "Armor")


func update_helath_bar(new_hp_value : int, type : String):
	if type == "Health":
		health_bar_tween.interpolate_property(
		health_bar, "value", health_bar.value, new_hp_value, 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT
		)
		health_bar_tween.start()

	elif type == "Armor":
		armor_bar_tween.interpolate_property(armor_bar, "value", armor_bar.value, new_hp_value, 0.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
		armor_bar_tween.start()


func _on_Player_hp_changed(new_hp : int):
	var new_health = int((100 - MIN_HEALTH) * float(new_hp) / max_hp) + MIN_HEALTH
	update_helath_bar(new_health, "Health")


func _on_Player_regen_hp(hp : int):
	if can_heal_armor:
			var update_armor_health: int = int((100 - MIN_HEALTH) * float(hp) / max_hp) + MIN_HEALTH
			update_helath_bar(update_armor_health, "Armor")



func _on_Player_armor_hp_changed(new_hp):
	if is_instance_valid(armor_bar):
		var new_health = int((100 - MIN_HEALTH) * float(new_hp) / armor_hp) + MIN_HEALTH
		update_helath_bar(new_health, "Armor")
	
		if new_hp <= 0:
			can_heal_armor = false



func _on_Player_update_hp_items(hp):
	var new_health = int((100 - MIN_HEALTH) * float(hp) / max_hp) + MIN_HEALTH
	update_helath_bar(new_health, "Health")

