class_name ButtonSwitch extends CharacterBody2D

@export var target: ButtonTarget
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	animation_player.play("pressed")
	target.is_active = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	animation_player.play("unpressed")
	target.is_active = false
