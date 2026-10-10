class_name SaveGame extends Node

signal save 
signal load 
signal delete

var oneCompleted: bool = false
var twoCompleted: bool = false
var threeCompleted: bool = false
var fourCompleted: bool = false
var fiveCompleted: bool = false
	
func _ready() -> void:
	save.connect(_on_save)

func _on_save():
	SaveSystem.set_var("Completion", SaveGame.new())