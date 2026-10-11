class_name SaveGame extends Resource

var oneCompleted: bool = false
var twoCompleted: bool = false
var threeCompleted: bool = false

# RGB = 0, 1, 2
var colorsCollected: Array[bool] = [false, false, false]
	
func _ready() -> void:
	colorsCollected[0] = true
