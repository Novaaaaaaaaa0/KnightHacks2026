extends Node2D

signal save 
signal load 
signal delete
signal level_complete

@export var isInteractable: bool = false
@export var currentFlower: String = "none"
@export var currentLevel: int
@onready var numCollected = 0

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
					numCollected += 1
				"green":
					print("Interacted with Green Flower")
					numCollected += 1
				"blue":
					print("Interacted with Blue Flower")
					numCollected += 1
				"teleport":
					if numCollected == 3:
						load_next_level()
			check_level_completion()
		elif Input.is_action_pressed("Interaction"):
			print("Nothing to interact with.")
				
func _on_save():
	SaveSystem.set_var("Completion", SaveGame.new())

func check_level_completion():
	if numCollected >= 3:
		level_complete.emit()
		print("Level requirements completed")

func load_next_level():
	numCollected = 0
	if currentLevel != null:
		match currentLevel:
			1:
				CompletionManager.level1Complete.emit(1)
				get_tree().change_scene_to_file("res://scenes/maze.tscn")
			2:
				CompletionManager.level2Complete.emit(2)
				get_tree().change_scene_to_file("res://scenes/fight_level.tscn")
			3:
				CompletionManager.level3Complete.emit(3)
				pass
