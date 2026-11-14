extends Node2D

@onready var back = $Control/Buttons/Back
@onready var lvl2 = $Control/Buttons/Level2
@onready var lvl3 = $Control/Buttons/Level3
@onready var updateSave = $"/root/UpdateSave"

func _ready() -> void:
	#lvl2.visible = false
	#lvl3.visible = false
	pass

func _process(_delta) -> void:
	
	#if(updateSave.oneCompleted == true):
	#	lvl2.visible = true
	#if(updateSave.twoCompleted == true):
	#	lvl3.visible = true
	pass
	
func _on_level_1_pressed() -> void:
	LevelSwitch.change_level("res://scenes/puzzle1.tscn")

func _on_level_2_pressed() -> void:
	LevelSwitch.change_level("res://scenes/maze.tscn")

func _on_level_3_pressed() -> void:
	LevelSwitch.change_level("res://scenes/fight_level.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/titlescreen.tscn")
