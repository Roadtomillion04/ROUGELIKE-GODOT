extends Swords

onready var hammer_hitbox = get_node("SlashSprite/HitBox")

func _process(_delta):
	var mouse_direction = (get_global_mouse_position() - global_position).normalized()
	
	if Input.is_action_pressed("ui_attack") and not sword_animation.is_playing() and not weapon_changed: 
		sword_animation.play("HammerAnimation")
		hammer_hitbox.knockback_direction = mouse_direction
		
