extends Node2D
@onready var leftLimit = $"Camera Limits/leftLimit"
@onready var rightLimit = $"Camera Limits/rightLimit"
@onready var topLimit = $"Camera Limits/topLimit"
@onready var bottomLimit = $"Camera Limits/bottomLimit"
@onready var endOfLevel = $EndOfLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var gretta = $mainCharacter/CollisionShape2D/AnimatedSprite2D
	gretta.play("Front Standing")
	GlobalVars.level_complete.connect(_on_level_complete)
	GlobalVars.numCollected = -1
	GlobalVars.currentLevel = 4
	GlobalVars.currentInteraction = "none"
	GlobalVars.isInteractable = false
	
	var cam = $mainCharacter/Camera2D
	cam.set_limit(SIDE_LEFT, int(leftLimit.position.x))
	cam.set_limit(SIDE_RIGHT, int(rightLimit.position.x))
	cam.set_limit(SIDE_TOP, int(topLimit.position.y))
	cam.set_limit(SIDE_BOTTOM, int(bottomLimit.position.y))

func _on_level_complete():
	endOfLevel.activated()
	pass
