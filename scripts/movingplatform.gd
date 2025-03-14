class_name MovingPlatform extends Node2D

@export var looping: bool = true

@onready var path_follow_2d: PathFollow2D = $MovingPlatform/PathFollow2D


var is_active: bool = false

func _ready() -> void:
	path_follow_2d.loop = looping

func _process(_delta: float) -> void:
	if is_active:
		active()
	else:
		inactive()

func active() -> void:
	path_follow_2d.progress += 2

func inactive() -> void:
	path_follow_2d.progress -= 2
