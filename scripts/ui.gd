extends CanvasLayer

@onready var progress_bar: TextureProgressBar = $ProgressBar


func remove_health() -> void:
	progress_bar.value -= 1

func add_health() -> void:
	progress_bar.value += 1
