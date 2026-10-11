extends Node2D

# Sets camera limits based on level limits
func _ready() -> void:
	var gretta = $mainCharacter/CollisionShape2D/AnimatedSprite2D
	gretta.play("Front Standing")
	
	var cam = $mainCharacter/Camera2D
	cam.set_limit(SIDE_LEFT, int($leftLimit.position.x))
	cam.set_limit(SIDE_RIGHT, int($rightLimit.position.x))
	cam.set_limit(SIDE_TOP, int($topLimit.position.y))
	cam.set_limit(SIDE_BOTTOM, int($bottomLimit.position.y))
