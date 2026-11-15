extends CharacterBody2D

@onready var animation = $AnimatedSprite2D
@onready var battle = preload("res://scenes/battle.tscn")
@onready var animationPlayer = $AnimationPlayer

@export var enemyName = "Red Final Boss"
@export var enemyResource: Resource = null
var battle_started = false
var direction = Vector2.RIGHT
var battle_instance

func start_battle():
	battle_instance = battle.instantiate()
	battle_instance.get_resource(enemyResource)
	battle_instance.enemyDied.connect(_on_enemy_died)
	battle_instance.playerDied.connect(_on_player_died)
	
	var tree = get_tree()
	if(tree == null):
		return
	var old_scene = tree.current_scene
	GlobalVars.active_scene = old_scene
	
	tree.root.remove_child(old_scene)
	
	tree.root.add_child(battle_instance)
	tree.current_scene = battle_instance
	#old_scene.queue_free()
	
	#get_tree().change_scene_to_file("res://scenes/battle.tscn")

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if battle_started == true:
		return
	
	if body.is_in_group("player"):
		battle_started = true
		$Area2D.set_deferred("monitoring", false)
		
		print("Collided with player!")
		animationPlayer.play("battle")
		await animationPlayer.animation_finished
		await get_tree().create_timer(0.25).timeout
		call_deferred("start_battle")

func _on_enemy_died():
	State.enemiesDefeated += 1
	if(State.enemiesDefeated % 5 == 0):
		State.level_up()
		print("The player leveled up!")
	queue_free()

func _on_player_died():
	queue_free()

	
