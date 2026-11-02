extends Node2D

signal level1Complete
signal level2Complete
signal level3Complete

func _ready() -> void:
	level1Complete.connect(unlockGate)
	level2Complete.connect(unlockGate)
	level3Complete.connect(unlockGate)
	
func unlockGate(level: int):
	var end_of_level = get_tree().get_first_node_in_group("end_of_level")
	match level:
		1:
			#get_node("EndOfLevel").frame = 1
			print("ran unlockGate()")
		#2:
			#get_node("/root/maze/EndOfLevel").frame = 1
			#print("ran unlockGate()")
		#3:
			#get_node("/root/fightLevel/EndOfLevel").frame = 1
			#print("ran unlockGate()")
	
