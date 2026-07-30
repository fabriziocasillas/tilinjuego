extends CanvasLayer

var start = 0
func _ready() -> void:
	pass # Replace with function body.


func _unhandled_input(event):
	# para arrancar el juego es esto
	if event is InputEventKey:
		if event.pressed and event.keycode != KEY_ESCAPE:
			get_tree().paused = false
			%Gamestart.visible = false
			%Pause.visible = false
			start = 0
	#restart is a key action binded to r
	if event.is_pressed() and event.is_action_pressed("restart"):
		get_tree().paused = true
		get_tree().reload_current_scene()
	# pause action in escape, uses the native way to pause and makes visible the pause screen
	if event.is_pressed() and event.keycode == KEY_ESCAPE:
		if start == 0:
			start = 1
			get_tree().paused = true
			%Pause.visible = true
		else:
			start = 0
			get_tree().paused = false
			%Pause.visible = false
