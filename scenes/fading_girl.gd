extends Node2D

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if(body.is_in_group("player")):
		GlobalVars.isInteractable = true
		GlobalVars.currentInteraction = "fading_girl"
	

func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	GlobalVars.isInteractable = false
	GlobalVars.currentInteraction = "none"
