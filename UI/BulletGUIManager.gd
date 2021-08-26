extends HBoxContainer

onready var bullet_sprite = get_node("BulletSprite")
onready var bullet_label = get_node("BulletLabel")
onready var player = get_tree().current_scene.get_node("Player")

func _ready():
	bullet_label.text = str(player.ammo)

func _update_ammo(ammo_left):
	bullet_label.text = str(ammo_left)

	if ammo_left == 0:
		get_tree().call_group("Guns", "_on_no_ammo", false)
	
	else:
		get_tree().call_group("Guns", "_on_no_ammo", true)
