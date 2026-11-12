extends Control

@export var enemy: Resource = null

@onready var textbox = $Textbox
@onready var textboxLabel = $Textbox/Textbox/Label
@onready var actionsPanel = $ActionsPanel
@onready var playerProgressBar = $PlayerPanel/MarginContainer/PlayerData/ProgressBar
@onready var enemyProgressBar = $EnemyContainer/ProgressBar
@onready var enemyTexture = $EnemyContainer/Enemy
@onready var animationPlayer = $AnimationPlayer
@onready var music = $battleMusic
@onready var playedLostSound = $DeathSound
@onready var playedWonSound = $WinSound

var isDefending = false
var currentPlayerHealth = 0
var currentEnemyHealth = 0
var activeBattle = false

signal textboxClosed
signal endOfBattle
signal playerDied
signal enemyDied

func _ready() -> void:
	actionsPanel.hide()
	if(activeBattle == true):
		PauseGui.isPauseable = false
		set_health(playerProgressBar,State.current_health, State.max_health)
		set_health(enemyProgressBar, enemy.health, enemy.health)
		enemyTexture.texture = enemy.texture
		currentPlayerHealth = State.current_health
		currentEnemyHealth = enemy.health
		
		
		randomize()
		textbox.hide()
		actionsPanel.hide()
		
		display_text("A wild %s appears!" % [enemy.name])
		await textboxClosed
		actionsPanel.show()
	
func get_resource(enemyResource):
	enemy = enemyResource
	activeBattle = true
	
func display_text(text):
	textbox.show()
	textboxLabel.text = text
	
func set_health(progressBar, health, maxHealth):
	progressBar.value = health
	progressBar.max_value = maxHealth
	progressBar.get_node("Label").text = "HP:%d/%d" % [health, maxHealth]
	pass
	
func enemy_turn():
	actionsPanel.hide()
	display_text("%s charges at you!" % enemy.name)
	await textboxClosed
	
	if isDefending:
		isDefending = false
		animationPlayer.play("mini_shake")
		await animationPlayer.animation_finished
		
		display_text("You defended!")
		await textboxClosed
		actionsPanel.show()
	else:
		var success = [0,1,2,3,4].pick_random()
		if(success > 0):
			animationPlayer.play("shake")
			await animationPlayer.animation_finished
			
			display_text("The attack was very effective!")
			await textboxClosed
			currentPlayerHealth = max(0, currentPlayerHealth - enemy.damage)
			set_health(playerProgressBar, currentPlayerHealth, State.max_health)
			
			if(currentPlayerHealth <= 0):
				music.stop()
				playedLostSound.play()
				display_text("You died...")
				await textboxClosed
				
				await get_tree().create_timer(0.25).timeout
				State.current_health = currentPlayerHealth
				playerDied.emit()
				endOfBattle.emit()
				#get_tree().quit() # CHANGE EVERY INSTANCE OF THIS TO SIMPLY FREE THE SCENE
				
			
		elif(success == 0):
			display_text("You dodged the attack!")
			await textboxClosed
			
		actionsPanel.show()
	

func _input(event):
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("Left Click"):
		textbox.hide()
		textboxClosed.emit()

func _on_run_pressed() -> void:
	var successRate = [0,1].pick_random()
	actionsPanel.hide()
	
	if(successRate == 1):
		display_text("You escaped!")
		await textboxClosed
		await get_tree().create_timer(0.25).timeout
		enemyDied.emit() # despawns the enemy, maybe change in the future?
		endOfBattle.emit() 
		#get_tree().quit()
	elif(successRate == 0):
		display_text("You failed to escape!")
		await textboxClosed
		actionsPanel.show()
		enemy_turn()
	

func _on_attack_pressed() -> void:
	actionsPanel.hide()
	display_text("You wack the enemy with your paintbrush!")
	await textboxClosed
	
	var success = [0,1,2].pick_random()
	if(success > 0):
		animationPlayer.play("enemy_damaged")
		await animationPlayer.animation_finished
		
		display_text("The attack was very effective!")
		await textboxClosed
		currentEnemyHealth = max(0, currentEnemyHealth - State.damage)
		set_health(enemyProgressBar, currentEnemyHealth, enemy.health)
		
		if(currentEnemyHealth == 0):
			music.stop()
			playedWonSound.play()
			display_text("The enemy was defeated!")
			await textboxClosed
			
			animationPlayer.play("enemy_died")
			await animationPlayer.animation_finished
			
			await get_tree().create_timer(0.3).timeout
			PauseGui.isPauseable = true
			enemyDied.emit()
			endOfBattle.emit()
			#get_tree().quit()
		
		enemy_turn()
	elif(success == 0):
		display_text("Your attack failed!")
		await textboxClosed
		
		enemy_turn()

func _on_defeend_pressed() -> void:
	isDefending = true
	actionsPanel.hide()
	
	display_text("You block with your paintbrush!")
	await textboxClosed
	
	await get_tree().create_timer(0.25).timeout
	
	enemy_turn()


func _on_end_of_battle() -> void:
	var tree = get_tree()
	var battle_scene = tree.current_scene
	var old_scene = GlobalVars.active_scene
	
	tree.root.add_child(old_scene)
	battle_scene.queue_free()
	tree.current_scene = old_scene
	#battle_scene.queue_free()
	# NOT SAVING OLD SCENE CORRECTLY
	# INSTEAD JUST PLAYS BATTLE SCENE AGAIN
	# MUST FIX!!!!!!!!!!!!!!!!!!!!
	#get_tree().quit()
	pass
