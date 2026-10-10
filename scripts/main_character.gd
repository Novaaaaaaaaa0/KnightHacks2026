extends CharacterBody2D

@export var speed = 100
@onready var gretta_sprite = $CollisionShape2D/AnimatedSprite2D

func get_input():
	var input_direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	velocity = input_direction * speed

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()


# Most Inefficient animation code in the world
func _process(_delta):
	
	#moving down
	if Input.is_action_pressed("moveDown"):
		gretta_sprite.play("Front Walking")
	if Input.is_action_just_pressed("moveDown"):
		gretta_sprite.play("Front Standing")
		
	# moving up
	if Input.is_action_pressed("moveUp"):
		gretta_sprite.play("Back Walking")
	if Input.is_action_just_pressed("moveUp"):
		gretta_sprite.play("Back Standing")
		
	# moving left
	if Input.is_action_pressed("moveLeft"):
		gretta_sprite.play("Left Walking")
	if Input.is_action_just_pressed("moveLeft"):
		gretta_sprite.play("Left Standing")
		
	# moving right
	if Input.is_action_pressed("moveRight"):
		gretta_sprite.play("Right Walking")
	if Input.is_action_just_pressed("moveRight"):
		gretta_sprite.play("Right Standing")
		
