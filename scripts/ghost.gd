extends CharacterBody2D

@export var speed: float = 150.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction := Vector2.DOWN


func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

	var possible_directions := [
		Vector2.UP,
		Vector2.DOWN,
		Vector2.LEFT,
		Vector2.RIGHT
	]

	direction = possible_directions.pick_random()
	print(direction)


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(direction * speed * delta)

	if collision:
		# Turn completely around.
		direction = -direction

		# Move slightly away from the wall to prevent sticking.
		move_and_collide(direction * 2.0)

	if direction.x != 0.0:
		sprite.flip_h = direction.x < 0.0
