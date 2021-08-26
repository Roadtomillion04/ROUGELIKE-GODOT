extends Weapons
class_name Swords

onready var sword_animation = get_node("Node2D/AnimationPlayer")
onready var sword_hitbox = get_node("Node2D/Sprite/HitBox")
onready var charge_particles = get_node("Node2D/Sprite/ChargeParticles")

var weapon_changed : bool = false

func _ready():
	$SlashSprite.hide()
	$Node2D/Sprite/HitBox/CollisionShape2D.disabled = true
	$SlashSprite/HitBox/CollisionShape2D.disabled = true


func _process(_delta):
	var mouse_direction = (get_global_mouse_position() - global_position).normalized()


	if not sword_animation.is_playing():
		rotation = mouse_direction.angle()
	
	sword_hitbox.knockback_direction = mouse_direction

	if not sword_animation.is_playing():
		if scale.y == 1 and mouse_direction.x < 0:
			scale.y = -1

		elif scale.y == -1 and mouse_direction.x > 0:
			scale.y = 1


	if Input.is_action_just_pressed("ui_attack") and not sword_animation.is_playing() and not weapon_changed: 
		sword_animation.play("charge")

	elif Input.is_action_just_released("ui_attack"): 
		if sword_animation.is_playing() and sword_animation.current_animation == "charge":
			sword_animation.play("SwordAnimation")

		elif charge_particles.emitting:
			sword_animation.play("circular_attack")



func cancel_attack():
	sword_animation.play("cancel_attack")
