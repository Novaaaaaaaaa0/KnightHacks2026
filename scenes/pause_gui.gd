extends CanvasLayer

@export var isPauseable = true

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	pause()

func pause():
	if Input.is_action_just_pressed("pause"): #maybe need to add and if isPauseable
		if get_tree().paused == false:
			get_tree().paused = true
		else:
			get_tree().paused = false	
		visible = !visible

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/titlescreen.tscn")


func _on_unpause_pressed() -> void:
	get_tree().paused = false
	visible = false
