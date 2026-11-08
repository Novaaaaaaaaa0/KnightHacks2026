extends Node2D

signal save 
signal load 
signal delete
signal level_complete

@export var isInteractable: bool = false
@export var currentInteraction: String = "none"
@export var currentLevel: int
@onready var numCollected = 0
@onready var dialogue = preload("res://scenes/dialogue_manager.tscn")
var dialogue_manager

var lines: Array[String] = []
var flowerCollected = [false, false, false] # 0 = red, 1 = green, 2 = blue

func _ready() -> void:
	dialogue_manager = dialogue.instantiate()
	get_tree().current_scene.add_child(dialogue_manager)
	save.connect(_on_save)

func _input(event):
	if (get_tree().current_scene.scene_file_path == 'res://scenes/titlescreen.tscn'):
		pass
	else:	
		if isInteractable == true && Input.is_action_just_pressed("Interaction"):
			match currentInteraction:
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
				"fading_girl":
					run_dialogue()
					
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

func run_dialogue():
	match currentLevel:
		1:
			if(numCollected != 3):
				lines = get_lines("res://scripts/Dialogue/lvl1start.txt")
			else:
				lines = get_lines("res://scripts/Dialogue/lvl1end.txt")
		2:
			if(numCollected != 3):
				lines = get_lines("res://scripts/Dialogue/lvl2start.txt")
			else:
				pass
		3:
			if(numCollected != 3):
				pass
			else:
				pass
	dialogue_manager.start_dialogue(lines);
	isInteractable = false
	
func get_lines(fileName):
	var result: Array[String] = []
	var file = FileAccess.open(fileName, FileAccess.READ)
	var i = 0
	while not file.eof_reached():
		var line = file.get_line()
		result.append(line)
		i += 1
	file.close()
	print(result)
	return result
