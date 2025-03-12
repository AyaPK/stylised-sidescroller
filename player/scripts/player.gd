extends CharacterBody2D

@export var speed: float = 250.0  # Max movement speed
@export var acceleration: float = 2500.0  # Speeding up rate
@export var friction: float = 2500.0  # Slowing down rate
@export var jump_velocity: float = -420.0  # Jumping strength
@export var gravity: float = 1200.0  # Gravity force
@export var air_control: float = 0.6  # Movement control in air (0.0 - 1.0)

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle movement input
	var direction: float = Input.get_axis("ui_left", "ui_right")
	var target_speed = direction * speed

	if direction != 0:
		var accel = acceleration if is_on_floor() else acceleration * air_control
		velocity.x = move_toward(velocity.x, target_speed, accel * delta)
		$Icon.flip_h = direction < 0 
		$AnimationPlayer.play("walk")
	else:
		var decel = friction if is_on_floor() else friction * air_control
		velocity.x = move_toward(velocity.x, 0, decel * delta)
		$AnimationPlayer.play("idle")

	# Jumping
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_velocity

	# Apply movement
	move_and_slide()
