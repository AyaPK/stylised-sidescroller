extends Camera2D

@export var decay : float = 0.8
@export var max_offset : Vector2 = Vector2(100, 75)
@export var max_roll : float = 0.1
@onready var follow_node: Player = $".."
@onready var light_detector: LightDetector = $"../LightDetector"


var trauma : float = 0.0
var trauma_power : int = 2

func _ready() -> void:
	randomize()

func _process(delta : float) -> void:
	if light_detector.hit_by_light:
		add_trauma(0.04)
	if follow_node:
		global_position = follow_node.global_position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	

## The function to use for adding trauma (screen shake)
func add_trauma(amount : float) -> void:
	trauma = min(trauma + amount, ((0.1) * -(Ui.hp.value - Ui.hp.max_value))/180)

func shake() -> void:
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)
