extends CharacterBody2D

enum{
	IDLE, 
	NEW_DIRECTION,
	WALKING
}

@onready var timer = $Timer
@onready var animation = $AnimatedSprite2D
@onready var battle = preload("res://scenes/battle.tscn")
@onready var animationPlayer = $AnimationPlayer

@export var health = 150
@export var speed = 25
@export var damage = 25
@export var enemyName = "slime"
@export var enemyResource: Resource = null
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

func start_battle():
	var battle_instance = battle.instantiate()
	battle_instance.get_resource(enemyResource)
	battle_instance.enemyDied.connect(_on_enemy_died)
	battle_instance.playerDied.connect(_on_player_died)
	
	var tree = get_tree()
	var old_scene = tree.current_scene
	GlobalVars.active_scene = old_scene
	
	tree.root.remove_child(old_scene)
	
	tree.root.add_child(battle_instance)
	tree.current_scene = battle_instance
	#old_scene.queue_free()
	
	#get_tree().change_scene_to_file("res://scenes/battle.tscn")

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		print("Collided with player!")
		animationPlayer.play("battle")
		await animationPlayer.animation_finished
		await get_tree().create_timer(0.25).timeout
		start_battle()

func _on_enemy_died():
	queue_free()

func _on_player_died():
	queue_free()
