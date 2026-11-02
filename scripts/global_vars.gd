extends Node2D

signal save 
signal load 
signal delete

@export var isInteractable: bool = false
@export var currentFlower: String = "none"
@onready var numCollected = 0
@onready var levelComplete = false

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
					CompletionManager.level1Complete.emit(1)
					numCollected += 1
				"green":
					print("Interacted with Green Flower")
					CompletionManager.level3Complete.emit(3)
					numCollected += 1
				"blue":
					print("Interacted with Blue Flower")
					CompletionManager.level2Complete.emit(2)
					numCollected += 1
		elif Input.is_action_pressed("Interaction"):
			print("Nothing to interact with.")
		check_level_completion()
				
func _on_save():
	SaveSystem.set_var("Completion", SaveGame.new())

func check_level_completion():
	if numCollected >= 3:
		levelComplete = true
		print("Level requirements completed")
	else:
		levelComplete = false
	
	
