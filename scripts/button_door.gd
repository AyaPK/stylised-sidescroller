class_name ButtonDoor extends ButtonTarget

var start_y: float

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if is_active:
		if !start_y:
			start_y = global_position.y
		velocity.y = -50
	else:
		velocity.y = 50

	if global_position.y <= start_y:
		move_and_slide()
	if global_position.y > start_y and start_y:
		global_position.y = start_y

func active() -> void:
	is_active = true

func inactive() -> void:
	is_active = false
