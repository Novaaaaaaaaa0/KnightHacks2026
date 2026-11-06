extends Node2D

var canTeleport = false

@onready var area = $EndOfLevel/Area2D

func _ready() -> void:
	%EndOfLevel.play("Default")	

func activated():
	%EndOfLevel.play("Activation")
	canTeleport = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalVars.isInteractable = true
	GlobalVars.currentInteraction = "teleport"

func _on_area_2d_body_exited(body: Node2D) -> void:
	GlobalVars.isInteractable = false
	GlobalVars.currentInteraction = "none"
