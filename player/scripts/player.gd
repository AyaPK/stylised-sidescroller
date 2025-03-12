class_name Player extends CharacterBody2D

@export var speed: float = 250.0
@export var acceleration: float = 2500.0
@export var friction: float = 2500.0
@export var jump_velocity: float = -420.0
@export var gravity: float = 1200.0
@export var air_control: float = 0.6 
@onready var light_detector: LightDetector = $LightDetector

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

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

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
	
	if light_detector.hit_by_light:
		modulate = Color(0.25, 0, 0)
	else:
		modulate = Color(1, 1, 1)
