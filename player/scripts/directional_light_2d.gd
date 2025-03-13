class_name LightDetector extends Node2D

@onready var player: CharacterBody2D = $".."

@export var line_length: float = 1000.0
@export var light_angle: float = 75.0
@export var side_offset: float = 40.0 

var hit_by_light: bool = true

func _process(_delta):
	queue_redraw()

func _draw():
	if player:
		var start_position = player.global_position
		var angle_radians = deg_to_rad(light_angle)

		var direction = Vector2(cos(angle_radians), -sin(angle_radians))
		var start_positions = [
			start_position,
			start_position - Vector2(side_offset, 0),
			start_position + Vector2(side_offset/2, 0)
		]

		var space_state = get_world_2d().direct_space_state
		var count: int = 0
		for start in start_positions:
			var end_position = start + direction * line_length
			var query = PhysicsRayQueryParameters2D.create(start, end_position)
			var result = space_state.intersect_ray(query)
			
			if result:
				count += 1
			if count != 3:
				hit_by_light = true
			else:
				hit_by_light = false
