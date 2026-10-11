extends Area2D

@onready var area = %InteractiveAreaDetection

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	GlobalVars.isInteractable = true
	GlobalVars.currentFlower = "red"

func _on_body_exited(body: Node2D) -> void:
	GlobalVars.isInteractable = false
	GlobalVars.currentFlower = "none"
