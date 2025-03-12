extends CanvasLayer

@onready var hp: TextureProgressBar = $hp
@onready var overscreen: ColorRect = $overscreen

func _process(delta: float) -> void:
	overscreen.modulate.a = 1 - (hp.value / hp.max_value)

func remove_health() -> void:
	hp.value -= 1

func add_health() -> void:
	hp.value += 1
