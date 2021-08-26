extends Weapons
class_name Guns, "res://v1.1 dungeon crawler 16x16 pixel pack/heroes/PixelWeapons2.png"

var weapon_changed : bool = false
var can_fire : bool = true

export(PackedScene) var PROJECTILE = preload("res://Weapons/Projectiles/Rocket.tscn")
export(float) var fire_rate : float = 0

onready var shoot_pos = get_node("Node2D/Position2D")
onready var fire_delay_timer = get_node("FireDelayTimer")
onready var animation_player = get_node("Node2D/AnimationPlayer")

func _ready():
	Global.pos = shoot_pos.position


func _process(_delta):
	Global.pos = shoot_pos.position
	
	var mouse_direction = (get_global_mouse_position() - global_position).normalized()
	
	rotation = mouse_direction.angle()
	
	if scale.y == 1 and mouse_direction.x < 0:
			scale.y = -1
	
	elif scale.y == -1 and mouse_direction.x > 0:
			scale.y = 1
	
	if Input.is_action_pressed("ui_attack") and not weapon_changed and fire_delay_timer.is_stopped() and can_fire: # only executes when stopped
		
		if name == "Spear":
			animation_player.play("SpearAnimation")
		
		fire_delay_timer.start(fire_rate)
		
		var projectile = PROJECTILE.instance()
		get_tree().current_scene.add_child(projectile)
		projectile.position = get_tree().current_scene.get_node("Player").position 
		
		projectile.rotation_degrees = rotation_degrees
		projectile.shot(projectile.position, mouse_direction)

		if name == "AK":
			animation_player.play("muzzle_flash")
		
			#we update ammo here
		player.ammo = clamp(player.ammo - 1, 0, 99) 
		get_tree().call_group("AmmoGUI", "_update_ammo", player.ammo)



func _on_no_ammo(value):
	can_fire = value
