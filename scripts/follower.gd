extends Node2D

var bullet_scene = preload("res://escenas/bullet.tscn")

var lados = 5

var player: CharacterBody2D

var player_position
var direction
var target_position: Vector2
var speed := 2000.0
var change
var bullet_speed = 150
signal velchange
var rotation_new = 0


func _ready():
	await get_tree().create_timer(5).timeout
	_on_visible_on_screen_notifier_2d_screen_exited()
	add_to_group("enemigos")
	adjust_bullet_speed_loop()
	await get_tree().create_timer(5).timeout
	go_to_screen_random()
	$Rotation.start()

	randomize()

func _physics_process(delta):
	rotation = lerp_angle(self.rotation, rotation_new, delta * 2.0) 
	if target_position != Vector2.ZERO:
		var direction = (target_position - global_position).normalized()
		position += direction * speed * delta

		if global_position.distance_to(target_position) < 22.0:
			target_position = Vector2.ZERO


func _on_timer_timeout() -> void:

	for i in lados:
		var bullet = bullet_scene.instantiate() 
		bullet.global_position = global_position
		
		var angle = rotation + (2 * PI / lados) * i
		bullet.rotation = angle
		
		bullet.set_speed(bullet_speed) 
		
		get_parent().add_child(bullet)


func _on_patron_timeout() -> void:
	lados = randi() % 10 + 2


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	go_to_player()


func go_to_player() -> void:
	if player:
		var direction = player.global_position

		var offset_x = randi() % 50 + 30
		var offset_y = randi() % 10 + 20

		if randi() % 2 == 0:
			offset_x *= -1
		if randi() % 2 == 0:
			offset_y *= -1

		target_position = direction + Vector2(offset_x, offset_y)
		
func go_to_screen_random() -> void:
	if player:
		var direction = player.global_position

		var offset_x = randi() % 100 + 200
		var offset_y = randi() % 100 + 200

		if randi() % 2 == 0:
			offset_x *= -1
		if randi() % 2 == 0:
			offset_y *= -1

		target_position = direction + Vector2(offset_x, offset_y)
func increase_difficulty():
	var tim = $Timer.wait_time
	$Timer.wait_time = max(tim - 0.1, 0.4)
	
func adjust_bullet_speed_loop() -> void:
	while bullet_speed < 550:
		var change = randi() % 5 + 10  # entre 10 y 14
		await get_tree().create_timer(change).timeout

		var increase = randi() % 25 + 20  # entre 20 y 44
		bullet_speed += increase


func _on_goto_timeout() -> void:
	go_to_screen_random()


func _on_rotation_timeout() -> void:
 
	rotation_new = randf() * TAU
