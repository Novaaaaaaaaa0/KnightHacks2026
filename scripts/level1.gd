extends Node2D

var colorMaterial = material as ShaderMaterial

@onready var endOfLevel = $EndOfLevel
@onready var fadingGirl = $FadingGirl
@onready var fgEndPos = $fadingGirlNewPos

# Sets camera limits based on level limits
func _ready() -> void:
	var gretta = $mainCharacter/CollisionShape2D/AnimatedSprite2D
	gretta.play("Front Standing")
	GlobalVars.level_complete.connect(_on_level_complete)
	GlobalVars.currentLevel = 1
	GlobalVars.currentInteraction = "none"
	GlobalVars.isInteractable = false
	GlobalVars.numCollected = 0
	GlobalVars.flowerCollected[0] = false
	GlobalVars.flowerCollected[1] = false
	GlobalVars.flowerCollected[2] = false
	
	var cam = $mainCharacter/Camera2D
	cam.set_limit(SIDE_LEFT, int($leftLimit.position.x))
	cam.set_limit(SIDE_RIGHT, int($rightLimit.position.x))
	cam.set_limit(SIDE_TOP, int($topLimit.position.y))
	cam.set_limit(SIDE_BOTTOM, int($bottomLimit.position.y))

func _on_level_complete()->void: 
	material = null
	$Completion.show()
	$"Flowers Collected".play("Flowers Collected")
	await $"Flowers Collected".animation_finished
	$Completion.hide()
	endOfLevel.activated()
	fadingGirl.global_position = fgEndPos.global_position
	pass
