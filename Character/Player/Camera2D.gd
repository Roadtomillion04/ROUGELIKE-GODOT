extends Camera2D
#
var screen_shake_start = false
var shake_intensity = 0
#
onready var screen_shake_timer = get_node("ScreenShakeTimer")
#
func _ready():
	Global.camera = self
#
#
func _process(delta):
	zoom = lerp(zoom, Vector2(1, 1), 0.3)

	if screen_shake_start:
		global_position += Vector2(rand_range(-shake_intensity, shake_intensity), rand_range(-shake_intensity, shake_intensity)) * delta


func screen_shake(intensity, _time):
	zoom = Vector2(1, 1) - Vector2(intensity * 0.002, intensity * 0.002)
	shake_intensity = intensity
	#screen_shake_timer.wait_time = time
	screen_shake_timer.start()
	screen_shake_start = true


func _on_ScreenShakeTimer_timeout():
	screen_shake_start = false
	#zoom = Vector2(1, 1)
	global_position = get_parent().global_position 
