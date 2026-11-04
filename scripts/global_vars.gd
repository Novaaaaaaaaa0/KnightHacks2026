extends Node2D

signal save 
signal load 
signal delete
signal level_complete

@export var isInteractable: bool = false
@export var currentFlower: String = "none"
@export var currentLevel: int
@onready var numCollected = 0

var flowerCollected = [false, false, false] # 0 = red, 1 = green, 2 = blue

func _ready() -> void:
	save.connect(_on_save)

func _input(event):
	if (get_tree().current_scene.scene_file_path == 'res://scenes/titlescreen.tscn'):
		pass
	else:	
		if isInteractable == true && Input.is_action_pressed("Interaction"):
			match currentFlower:
				"red":
					if(flowerCollected[0] == false):
						print("Interacted with Red Flower")
						numCollected += 1
						flowerCollected[0] = true
				"green":
					if(flowerCollected[1] == false):
						print("Interacted with Green Flower")
						numCollected += 1
						flowerCollected[1] = true
				"blue":
					if(flowerCollected[2] == false):
						print("Interacted with Blue Flower")
						numCollected += 1
						flowerCollected[2] = true
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
	flowerCollected[0] = false
	flowerCollected[1] = false
	flowerCollected[2] = false
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
