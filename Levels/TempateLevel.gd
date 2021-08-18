extends Node2D

onready var user_interface = get_node("UI/Control")

func _init():
	randomize() # to place random rooms
	
	var screen_size = OS.get_screen_size()
	var window_size = OS.get_window_size()
	
	OS.set_window_position(screen_size * 0.5 - window_size * 0.5)

func _ready():
	user_interface.hide()



