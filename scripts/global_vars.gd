extends Node2D

signal save 
signal load 
signal delete

@export var isInteractable: bool = false
@export var currentFlower: String = "none"

func _ready() -> void:
	save.connect(_on_save)

func _input(event):
	if (get_tree().current_scene.scene_file_path == 'res://scenes/titlescreen.tscn'):
		pass
	else:	
		if isInteractable == true && Input.is_action_pressed("Interaction"):
			match currentFlower:
				"red":
					print("Interacted with Red Flower")
				"green":
					print("Interacted with Green Flower")
				"blue":
					print("Interacted with Blue Flower")
		elif Input.is_action_pressed("Interaction"):
			print("Nothing to interact with.")
				
func _on_save():
	SaveSystem.set_var("Completion", SaveGame.new())