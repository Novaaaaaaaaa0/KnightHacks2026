extends CharacterBody2D

@export var speed: float = 150.0

@onready var sprite: Sprite2D = $CollisionShape2D/AnimatedSprite2D

var direction := Vector2.RIGHT


func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

	# Choose a random starting direction.
	var possible_directions := [
		Vector2.UP,
		Vector2.DOWN,
		Vector2.LEFT,
		Vector2.RIGHT
	]

	direction = possible_directions.pick_random()


func _physics_process(delta: float) -> void:
	var movement := direction * speed * delta
	var collision := move_and_collide(movement)

	if collision:
		# Reflect the movement direction away from the wall.
		direction = direction.bounce(collision.get_normal()).normalized()

	if direction.x != 0.0:
		sprite.flip_h = direction.x < 0.0
