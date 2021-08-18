extends Enemy

onready var hitbox = get_node("HitBox")
onready var hitbox_collision = get_node("HitBox/CollisionShape2D")
onready var angry_sprite = get_node("AnimatedSprite/AngryMark")

func _process(_delta):
	if hitbox_collision:
		hitbox.knockback_direction = velocity.normalized()


