extends CharacterBody2D
var health = 3.0
signal health_depleted
@export var rotation_speed = 1.5
var rotation_direction = 0
var z = 0
signal attacked(hlt)
signal positionb(pos: Vector2)
const DAMAGE_RATE = 0.5
var is_dashing := false
var dash_duration := 0.2
var dash_timer := 0.0
var can_dash := true
var dash_cooldown := 1.0
var dash_force := 2000




func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if is_dashing:
		velocity = direction * dash_force
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
	else:
		velocity = direction * 400
		if Input.is_action_just_pressed("dash") and can_dash and direction != Vector2.ZERO:
			is_dashing = true
			dash_timer = dash_duration
			can_dash = false
			$DashCooldownTimer.start()
	if direction != Vector2.ZERO:
		look_at(global_position + direction)
		rotation -= deg_to_rad(270)  

	move_and_slide()


		
	var overlapping_bodies = $HurtBox.get_overlapping_bodies()
	if overlapping_bodies.size() > 0:
		health -= DAMAGE_RATE * overlapping_bodies.size() * delta
		emit_signal("attacked", health )

		%ProgressBar.value = health
		%ProgressBar.max_value = 3.0

		if health <= 0.0:
			health_depleted.emit()
			



	


func _on_dash_cooldown_timers_timeout() -> void:
	can_dash = true
