extends Node2D

signal level1Complete
signal level2Complete
signal level3Complete

func _ready() -> void:
	level1Complete.connect(unlockGate)
	level2Complete.connect(unlockGate)
	level3Complete.connect(unlockGate)
	
func unlockGate(level: int):
	match level:
		1:
			get_node("/root/Puzzles/EndOfLevel").frame = 1
			print("ran unlockGate()")
		2:
			get_node("/root/maze/EndOfLevel").frame = 1
			print("ran unlockGate()")
		3:
			get_node("/root/fightLevel/EndOfLevel").frame = 1
			print("ran unlockGate()")
	
