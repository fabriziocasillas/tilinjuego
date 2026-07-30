extends Node2D
var que
signal bulletvelocity
signal numofbullets
signal specialattack
var enemies = 0
var mobs = 0
var start = true
func _ready():
	%Pause.visible = false
	%Gamestart.visible = true
	get_tree().paused = true
	spawn_mob()
	$enemy.player=($Player)
	$Diff.start()
	$Life.player=($Player)
	$Mobs.start()




#load a mob and spwan it adding it as childo to the game
func spawn_mob():
	var mob = preload("res://escenas/mob.tscn").instantiate()
	mob.player = $Player
	add_child(mob)
	
#load an enemy and spwan it adding it as childo to the game	
func spawn_enemy():
	var enemy = preload("res://escenas/enemy.tscn").instantiate()
	enemy.player = $Player
	add_child(enemy)


## everytime the timeout sends a signal the enemies either highten their difficulty, speed up 
##  or use the special attack sending a signal  for every thing, but just one
func _on_diff_timeout() -> void:


	que = randi() % 3 
	if(que == 0):
		emit_signal("bulletvelocity")
	elif(que == 1):
		for enemy in get_tree().get_nodes_in_group("enemigos"):
			enemy.increase_difficulty()
	elif(que == 2 ):
		emit_signal("specialattack")
		
		

#enemies capped at 6
func _on_enemies_timeout() -> void:
	if enemies < 5:
		spawn_enemy()
		enemies += 1
		print("enemy incoming ", enemies)
##gameover function
func _on_player_health_depleted() -> void:
	%Gamover.visible = true
	get_tree().paused = true

##to allow restart without death and unhandled events
##this happens everytime something not contemplated is pressed
func _unhandled_input(event):
	if event.is_action_pressed("restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()
	if event is InputEventKey:
		if event.pressed:
			get_tree().paused = false
			%Gamestart.visible = false



func _on_mobs_timeout() -> void:
	print("mob spawneado")
	mobs = randi()% 10 + 1
	for x in mobs:
		spawn_mob()


func _on_punish_timeout() -> void:
	$Punish.wait_time = randi() % 6 + 5
	print("punsih calleado, y sera llamado dentro de ", $Punish.wait_time, " segundos")
	$Punish.start()
