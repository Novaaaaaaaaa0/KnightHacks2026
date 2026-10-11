extends Control

func _process(_delta) -> void:
	var back = $Back
	var lvl1 = $Level1
	var lvl2 = $Level2
	var lvl3 = $Level3
	
	if back.button_pressed:
		get_tree().change_scene_to_file("res://scenes/titlescreen.tscn")
		
	if lvl1.button_pressed:
		get_tree().change_scene_to_file("res://scenes/puzzle1.tscn")
	
	if lvl2.button_pressed and UpdateSave.oneCompleted:
		get_tree().change_scene_to_file("res://scenes/maze.tscn")
		
	if lvl3.button_pressed and UpdateSave.twoCompleted:
		get_tree().change_scene_to_file("res://scenes/fight_level.tscn")
		
