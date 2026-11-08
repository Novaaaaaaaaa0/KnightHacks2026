extends CanvasLayer

@export var isPauseable = true

func _process(delta: float) -> void:
	pause()

func pause():
	if Input.is_action_just_pressed("pause") and isPauseable:
		visible = !visible
		get_tree().paused = !get_tree().paused

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/titlescreen.tscn")


func _on_unpause_pressed() -> void:
	get_tree().paused = false
	visible = false
