extends Node2D

@onready var endOfLevel = $EndOfLevel
@onready var fadingGirl = $FadingGirl

var colorMaterial = material as ShaderMaterial


# Sets camera limits based on level limits
func _ready() -> void:
	var gretta = $mainCharacter/CollisionShape2D/AnimatedSprite2D
	gretta.play("Front Standing")
	GlobalVars.level_complete.connect(_on_level_complete)
	GlobalVars.currentLevel = 3
	
	var cam = $mainCharacter/Camera2D
	cam.set_limit(SIDE_LEFT, int($leftLimit.position.x))
	cam.set_limit(SIDE_RIGHT, int($rightLimit.position.x))
	cam.set_limit(SIDE_TOP, int($topLimit.position.y))
	cam.set_limit(SIDE_BOTTOM, int($bottomLimit.position.y))

func _on_level_complete()->void: 
	material = null
	endOfLevel.activated()
