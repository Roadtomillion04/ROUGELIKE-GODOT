extends FiniteStateMachine

var dash_impluse : int = 5

func _init():
	_add_state("idle")
	_add_state("move")
	_add_state("hurt")
	_add_state("dash")
	_add_state("dead")

func _ready():
	set_state(states.idle)

func _state_logic(_delta):
	if state == states.move or state == states.idle:
		parent.get_input()
		parent.move()


func _get_transition():
	match state:
		states.idle:
			if parent.velocity.length() > 10: #Returns the length (magnitude) of this vector.
				return states.move

		states.move:
			if parent.velocity.length() < 10:
				return states.idle
		
		states.hurt:
			if not animation_player.is_playing():
				return states.idle
		
		states.dash:
			if not animation_player.is_playing():
				return states.idle
	return -1


func _enter_state(_previous_state, new_state):
	match new_state:
		states.idle:
			animation_player.play("idle")
		states.move:
			animation_player.play("run")
		states.hurt:
			animation_player.play("hurt")
		states.dash:
			animation_player.play("dash")
			parent.velocity *= dash_impluse
			parent.velocity.normalized()
		states.dead:
			animation_player.play("dead")
