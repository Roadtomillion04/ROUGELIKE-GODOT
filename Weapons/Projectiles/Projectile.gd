extends Node2D
class_name Projectile


onready var life_timer = get_node("LifeTimer")
onready var animation_player = get_node("AnimationPlayer")
onready var hitbox = get_node("Hitbox")
onready var player = get_tree().current_scene.get_node("Player")


var direction: Vector2
export(float) var velocity:float = 200
export(float) var life_time : float = 1
export(bool) var can_explode : bool = false
export(PackedScene) var smoke_effect = preload("res://Weapons/Projectiles/SmokeEffect/BulletSmoke.tscn")

func _ready():
	life_timer.wait_time = life_time
	$Hitbox/Sprite.visible = true
	$AnimatedSprite.visible = false

func shot(initial_postion, mouse_direction):
	position = initial_postion
	direction = mouse_direction
	hitbox.knockback_direction = mouse_direction
	life_timer.start()
	

func _physics_process(delta):
	position += direction * velocity * delta
	#velocity = float(lerp(velocity, 100, 0.03))


func _on_LifeTimer_timeout():
	if hitbox.collision_mask == 1 or hitbox.collision_mask == 4 and can_explode: 
		direction = Vector2.ZERO
		animation_player.play("Explode")

# As hitbox is using body.take_damage() it throws error for tilemap!
func _on_WallsDetector_body_entered(_body):
	velocity = 0
	animation_player.play("Hit_anim")
	
	Global.camera.screen_shake(5, 0.01)
	
	var smoke_scene = smoke_effect.instance()
	get_tree().current_scene.add_child(smoke_scene)
	smoke_scene.global_position = global_position
	smoke_scene.rotation_degrees = -rotation_degrees


func _on_Hitbox_body_entered(_body):
	velocity = 0
	animation_player.play("Hit_anim")
	
