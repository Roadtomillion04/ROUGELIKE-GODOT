extends Label

onready var tween = get_node("Tween")

		   # label size     from            
func start(size : Vector2, pos : Vector2, direction : int, distance : int = 12, label_text = "-1"):
	rect_min_size = size
	text = label_text

	tween.interpolate_property(self, "rect_position", pos, Vector2(pos.x, pos.y + distance * direction), 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT )
	
	tween.interpolate_property(self, "modulate", Color(0.1, 0.1, 0.1, 1), Color(0.1, 0.1, 0.1, 0), 0.3, Tween.TRANS_CIRC, Tween.EASE_IN)
	tween.start()


func _on_Tween_tween_completed(_object, _key):
	queue_free()
