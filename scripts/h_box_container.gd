extends HBoxContainer

@onready var timer = $"../../Timer"

func _process(_delta) -> void:
	
	var save = $VBoxContainer/Save

func _on_start_pressed() -> void:
	timer.start()
	await timer.timeout
	get_tree().change_scene_to_file("res://scenes/levelselect.tscn")


func _on_quit_pressed() -> void:
	timer.start()
	await timer.timeout
	get_tree().quit()
