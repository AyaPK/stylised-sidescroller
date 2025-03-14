extends Node

var scene_history: Array[String] = []

func load_scene(scene_path: String):
	print("aaaaa")
	if not ResourceLoader.exists(scene_path):
		push_error("Scene does not exist: " + scene_path)
		return

	if get_tree().current_scene:
		scene_history.append(get_tree().current_scene.scene_file_path)
	
	get_tree().change_scene_to_file(scene_path)

func reload_scene():
	var current_scene = get_tree().current_scene
	if current_scene:
		get_tree().reload_current_scene()

func go_back():
	if scene_history.is_empty():
		push_error("No previous scenes in history!")
		return

	var previous_scene = scene_history.pop_back()
	get_tree().change_scene_to_file(previous_scene)

func restart_game(first_scene: String):
	scene_history.clear()
	load_scene(first_scene)
