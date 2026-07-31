extends CanvasLayer

var start = 0



func _ready() -> void:
	pass # Replace with function body.



func _unhandled_input(event):
	# Para arrancar el juego
	if event is InputEventKey:
		if event.pressed and event.keycode != KEY_ESCAPE:
			get_tree().paused = false
			%Gamestart.visible = false
			%Pause.visible = false
			start = 0
		# pause action in escape, uses the native way to pause and makes visible the pause screen
		#also  checks for escape CHANGE LATER
		if event.pressed and event.keycode == KEY_ESCAPE:
			if start == 0:
				start = 1
				get_tree().paused = true
				%Pause.visible = true
			else:
				start = 0
				get_tree().paused = false
				%Pause.visible = false

	#restart is a key action binded to r
	if event.is_action_pressed("restart"):
		get_tree().paused = true
		get_tree().reload_current_scene()
