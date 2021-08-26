extends Node2D



onready var current_weapon = get_child(0)
onready var secondary_weapon = get_child(1)

var weapons: Array = []

func _ready():
	secondary_weapon.weapon_changed = true
	
	weapons = get_children()
	
	for weapon in weapons:
		weapon.hide() # all weapons will hide
#
#		get_tree().call_group("WeaponIndicator", "load_sprite", weapon.get_node("Node2D/Sprite")).texture
		
		
	current_weapon.show()


func _process(_delta):
	
	if is_instance_valid(secondary_weapon):
		
		if Input.is_action_just_pressed("switch_weapons"):
			if current_weapon == get_child(0):
				current_weapon.weapon_changed = true
				switch_weapons(get_child(1))
				secondary_weapon.weapon_changed = false
		
			elif current_weapon == get_child(1):
				secondary_weapon.weapon_changed = true
				switch_weapons(get_child(0))
				current_weapon.weapon_changed = false

	else:
		current_weapon = get_child(0)
		current_weapon.show()
		current_weapon.weapon_changed = false
		
		
		
		
func switch_weapons(weapon):
	current_weapon.hide()
	
	current_weapon = weapon
	current_weapon.show()


func drop_weapon(gun):
	secondary_weapon.queue_free()
	yield(get_tree().create_timer(1), "timeout")
	var rifle = gun.instance()
	call_deferred("add_child", rifle)
	secondary_weapon = rifle
	secondary_weapon.hide()
	secondary_weapon.weapon_changed = true
