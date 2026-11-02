extends HBoxContainer

func _process(_delta) -> void:
	var start = $VBoxContainer/Start
	var save = $VBoxContainer/Save
	
	if start.button_pressed:
		get_tree().change_scene_to_file("res://scenes/levelselect.tscn")
	
