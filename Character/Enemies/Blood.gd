extends CPUParticles2D


func _on_Timer_timeout():
	set_process_internal(false)
	$FadeTimer.start()


func _on_FadeTimer_timeout():
	modulate = int(lerp(1, 0, 0.25))
	#modulate = lerp(Color(1,1,1), Color(1,1,0), 0.25)
