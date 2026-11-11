extends CanvasLayer

func _on_quit_pressed() -> void:
	get_tree().paused = false
	State.current_health = 100
	get_tree().change_scene_to_file("res://scenes/titlescreen.tscn")

func _on_retry_pressed() -> void:
	get_tree().paused = false
	State.current_health = 100
	get_tree().reload_current_scene()
