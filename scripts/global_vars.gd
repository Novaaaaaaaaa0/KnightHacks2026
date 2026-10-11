extends Node2D

@export var isInteractable: bool = false
@export var currentFlower: String = "none"

func _input(event):
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
			
