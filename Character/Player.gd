extends Character

var charge_heavy = false

var screen_size

var items: int = 0
export(int) var ammo: int = 30

#const PROJECTILE = preload("res://Character/Player/Projectile.tscn")

signal regen_hp(hp)

onready var sword = get_node("WeaponManager").get_child(0)
onready var sword_animation = sword.get_node("Node2D/AnimationPlayer")
onready var sword_hitbox = sword.get_node("Node2D/Sprite/HitBox")
onready var particle_emiiter = get_node("Particles2D")
onready var animation_player = get_node("AnimationPlayer")

func _ready():
	screen_size = get_viewport_rect().size
#	Global.save_data["Position"] = global_position
#	Global.save_data["PlayerHp"] = self.hp
	if Global.save_data.Position != null:
		global_position = Global.save_data.Position
		hp = Global.save_data.PlayerHp
		armor_hp = Global.save_data.PlayerArmorHp
	else:
		Global.player_data(position, self.hp, self.armor_hp)

func _process(_delta):
	var mouse_direction = (get_global_mouse_position() - global_position).normalized()
	
	#shoot
#	if Input.is_action_just_pressed("shoot"):
#		var projectile = PROJECTILE.instance()
#		get_tree().current_scene.add_child(projectile)
#		projectile.position = shoot_pos.position
#		projectile.shot(position, mouse_direction)
	
	
	#player flip
	if not sword_animation.is_playing():
		if mouse_direction.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		#particle_emiiter.rotation_degrees = 90
	
		elif mouse_direction.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true
		#particle_emiiter.rotation_degrees = 90
	
	#sword rotation
	#if not sword_animation.is_playing():
		#sword.rotation = mouse_direction.angle()
	#knockback
	#sword_hitbox.knockback_direction = mouse_direction
	
	# sword position
	#if not sword_animation.is_playing():
		#if sword.scale.y == 1 and mouse_direction.x < 0:
			#sword.scale.y = -1
	
		#elif sword.scale.y == -1 and mouse_direction.x > 0:
		#	sword.scale.y = 1
	
	#clamping viewport to prevent oustside movement of screen
								   #min  #max
	#position.x = clamp(position.x, 10, screen_size.x)
	#position.y = clamp(position.y, 10, screen_size.y)

	if Input.is_action_just_pressed("dodge"):
		if not move_diection == Vector2.ZERO: # to do not dash at non movement
			state_machine.set_state(state_machine.states.dash)

func cancel_attack():
	$WeaponManager.current_weapon.cancel_attack()

func get_input():
	move_diection = Vector2.ZERO
	particle_emiiter.emitting = false
	
	if Input.is_action_pressed("down"):
		move_diection += Vector2.DOWN
		particle_emiiter.emitting = true
		particle_emiiter.rotation_degrees = 180
	
	if Input.is_action_pressed("up"): 
		move_diection += Vector2.UP
		particle_emiiter.emitting = true
		particle_emiiter.rotation_degrees = 0
	
	if Input.is_action_pressed("right"):
		move_diection += Vector2.RIGHT
		particle_emiiter.emitting = true
		particle_emiiter.rotation_degrees = 90
	
	if Input.is_action_pressed("left"): 
		move_diection += Vector2.LEFT   
		particle_emiiter.emitting = true
		particle_emiiter.rotation_degrees = 270
	
	
	#sword animation and player can only attack at move or idle!
	#if Input.is_action_pressed("ui_attack") and not sword_animation.is_playing(): 
		#sword_animation.play("Attack")
#		acceleration = 20
#		max_speed = 50
#		yield(sword_animation, "animation_finished")
#		acceleration = 40
#		max_speed = 100
	
	
	elif Input.is_action_just_pressed("heavy") and not sword_animation.is_playing(): 
		yield(get_tree().create_timer(1), "timeout")
		sword_animation.play("charging")
		yield(sword_animation, "animation_finished")
		charge_heavy = true

		
	if Input.is_action_just_released("heavy") and charge_heavy:
		charge_heavy = false
		sword_animation.play("Charged_attack")
		sword_hitbox.knockback_force = 270
		yield(sword_animation, "animation_finished")
		sword_hitbox.knockback_force = 140





func _on_HealthTimer_timeout():
	if armor_hp < max_hp:
		armor_hp = int(clamp(armor_hp + 1, 1, 4))
		emit_signal("regen_hp", armor_hp)


func update_items():
	items += 1
	get_tree().call_group("ItemList", "update_items", items)


func item_used():
	items -= 1
	get_tree().call_group("ItemList", "update_items", items)


func _on_pass_key_claimed():
	var key = Node.new()
	key.name = "PASS_KEY"
	add_child(key)
