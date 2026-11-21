extends Node

var current_health = 100
var max_health = 100
var damage = 25
var enemiesDefeated = 4
var healLvlUp = 0

signal levelUp

func level_up():
	current_health = max_health + 15
	damage += 10
	max_health += 15
	levelUp.emit()
	healLvlUp = healLvlUp + 5
