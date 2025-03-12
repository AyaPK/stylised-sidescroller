class_name Player extends CharacterBody2D

@export var speed: float = 250.0
@export var acceleration: float = 2500.0
@export var friction: float = 2500.0
@export var jump_velocity: float = -420.0
@export var gravity: float = 1200.0
@export var air_control: float = 0.6 
@onready var light_detector: LightDetector = $LightDetector
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Icon

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction: float = Input.get_axis("move_left", "move_right")
	var target_speed = direction * speed

	if direction != 0:
		var accel = acceleration if is_on_floor() else acceleration * air_control
		velocity.x = move_toward(velocity.x, target_speed, accel * delta)
		sprite.flip_h = direction < 0 
		
		# Only play walk animation if on the floor
		if is_on_floor():
			animation_player.play("walk")
	else:
		var decel = friction if is_on_floor() else friction * air_control
		velocity.x = move_toward(velocity.x, 0, decel * delta)

		# Only play idle if on the floor
		if is_on_floor():
			animation_player.play("idle")

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		animation_player.play("jump")

	move_and_slide()

	# Handle fall animation
	if velocity.y > 0 and not is_on_floor():
		animation_player.play("fall")

	if light_detector.hit_by_light:
		Ui.remove_health()
	else:
		Ui.add_health()
