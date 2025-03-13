extends CanvasLayer

@onready var hp: TextureProgressBar = $hp
@onready var overscreen: ColorRect = $overscreen
@onready var node_end: GPUParticles2D = $hp/node_end
@onready var node_end_2: GPUParticles2D = $hp/node_end2
@onready var node_end_3: GPUParticles2D = $hp/node_end3
@onready var hp_anim: AnimationPlayer = $hp/hp_anim

func _ready() -> void:
	node_end.emitting = false
	node_end_2.emitting = false
	node_end_3.emitting = false

func _process(_delta: float) -> void:
	overscreen.modulate.a = 1 - (hp.value / hp.max_value)
	node_end.global_position = Vector2(hp.global_position.x+(hp.value*1.28), hp.global_position.y)
	node_end_2.global_position = Vector2(hp.global_position.x+(hp.value*1.28), hp.global_position.y+10)
	node_end_3.global_position = Vector2(hp.global_position.x+(hp.value*1.28), hp.global_position.y+20)


func remove_health() -> void:
	hp.value -= 1
	node_end.emitting = true
	node_end_2.emitting = true
	node_end_3.emitting = true
	hp_anim.play("shaking")
	AudioManager.decrease_low_pass()

func add_health() -> void:
	hp.value += 1
	node_end.emitting = false
	node_end_2.emitting = false
	node_end_3.emitting = false
	hp_anim.play("still")
	AudioManager.increase_low_pass()
