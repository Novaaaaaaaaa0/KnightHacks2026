extends CharacterBody2D

@export var speed: int = 100
@onready var gretta_sprite = $CollisionShape2D/AnimatedSprite2D
var direction: String = "none"

func get_input() -> void:
	var input_direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	velocity = input_direction * speed

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()


# Most Inefficient animation + movement code in the world
func _process(_delta) -> void:
	
	var moving: bool = (Input.is_action_pressed("moveDown") || Input.is_action_pressed("moveUp") || Input.is_action_pressed("moveLeft") || Input.is_action_pressed("moveRight"))
	
	if (Input.is_action_pressed("Interaction")):
		if ((gretta_sprite.animation == ("Left Walking")) || (gretta_sprite.animation == ("Left Standing"))):
				gretta_sprite.play("Left Interact")
				
		elif ((gretta_sprite.animation == ("Right Walking")) || (gretta_sprite.animation == ("Right Standing"))):
				gretta_sprite.play("Right Interact")
				
	
	elif moving:
		#moving down
		if Input.is_action_pressed("moveDown"):
			gretta_sprite.play("Front Walking")	
			direction = "down"
		# moving up
		if Input.is_action_pressed("moveUp"):
			gretta_sprite.play("Back Walking")
			direction = "up"
		# moving left
		if Input.is_action_pressed("moveLeft"):
			gretta_sprite.play("Left Walking")
			direction = "left"
		# moving right
		if Input.is_action_pressed("moveRight"):
			gretta_sprite.play("Right Walking")
			direction = "right"
	
	else:
		match direction:
			"up":
				gretta_sprite.play("Back Standing")
			"down":
				gretta_sprite.play("Front Standing")
			"left":
				gretta_sprite.play("Left Standing")
			"right":
				gretta_sprite.play("Right Standing")
		direction = "none"
