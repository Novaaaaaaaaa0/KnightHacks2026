extends Node2D

enum{
	IDLE, 
	NEW_DIRECTION,
	WALKING
}

@onready var timer = $Timer
@onready var animation = $AnimatedSprite2D

var health = 150
var state = WALKING
var speed = 25
var direction = Vector2.RIGHT

func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	match state:
		IDLE:
			pass
		NEW_DIRECTION:
			direction = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN, Vector2.UP])
			state = IDLE
			
		WALKING:
			position -= delta * speed * direction
			
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
