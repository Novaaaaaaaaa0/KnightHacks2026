extends CharacterBody2D

enum{
	IDLE, 
	NEW_DIRECTION,
	WALKING
}

@onready var timer = $Timer
@onready var animation = $AnimatedSprite2D

@export var health = 150
@export var speed = 25
@export var damage = 25
@export var enemyName = "slime"
var state = WALKING
var direction = Vector2.RIGHT

func _ready() -> void:
	randomize()

func _physics_process(delta: float) -> void:
	
	match state:
		IDLE:
			velocity = Vector2.ZERO
			pass
		NEW_DIRECTION:
			direction = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN, Vector2.UP])
			state = choose([IDLE, WALKING])
		WALKING:
			#position -= delta * speed * direction OLD WAY
			velocity = speed * -direction
	
	move_and_slide()
	
	match direction:
		Vector2.RIGHT:
			animation.play("Right")
		Vector2.LEFT:
			animation.play("Left")
		Vector2.UP:
			animation.play("Front")
		Vector2.DOWN:
			animation.play("Back")

func choose(arr: Array):
	arr.shuffle()
	return arr.front()

func _on_timer_timeout() -> void:
	state = choose([IDLE, NEW_DIRECTION, WALKING])
	timer.start()
