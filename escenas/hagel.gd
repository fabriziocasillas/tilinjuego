extends CharacterBody2D

signal health_depleted
signal mob_died
var target_position
var move = false
var health = 3
var player: CharacterBody2D

func _ready() -> void:
	$Await.start()

	if player:
		var distance = randf_range(750.0, 1000.0)
		global_position = player.global_position + player.direction.normalized() * distance

		var direction = global_position.direction_to(player.global_position)
		
		rotation = direction.angle() + PI / 2


	disappear_after_delay()
	
	
func _physics_process(delta):
	if player && move == true:
		var directionang = global_position.direction_to(player.global_position)
		
		rotation = directionang.angle() + PI / 2
		
		velocity = directionang * 300.0
		move_and_slide()

func disappear_after_delay() -> void:
	await get_tree().create_timer(15).timeout

	while global_position.distance_to(player.global_position) < 1500:
		await get_tree().create_timer(4).timeout

	emit_signal("mob_died")
	queue_free()


func _on_await_timeout() -> void:
	move = true
