extends CharacterBody2D
# tried to do a seperate script,
# but lowkey not figuring that out rn so this is pasted in the other script 

@onready var gretta_sprite = $CollisionShape2D/AnimatedSprite2D

func _process(_delta):
	if Input.is_action_pressed("moveDown"):
		gretta_sprite.play("Front Walking")
	else:
		gretta_sprite.stop()
	if Input.is_action_pressed("moveUp"):
		gretta_sprite.play("Back Walking")
	else:
		gretta_sprite.stop()
	if Input.is_action_pressed("moveLeft"):
		gretta_sprite.play("Left Walking")
	else:
		gretta_sprite.stop()
	if Input.is_action_pressed("moveRight"):
		gretta_sprite.play("Right Walking")
	else:
		gretta_sprite.stop()
		
