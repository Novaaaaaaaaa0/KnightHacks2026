extends CanvasLayer

@onready var label = $ColorRect/Label
var counter = 0;

func _ready() -> void:
	label.text = str(counter) + "/3"
	GlobalVars.newFlower.connect(_on_new_flower)
	
func _on_new_flower():
	counter = GlobalVars.numCollected
	label.text = str(counter) + "/3"
