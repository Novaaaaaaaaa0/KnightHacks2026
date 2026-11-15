extends CanvasLayer


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/titlescreen.tscn")
