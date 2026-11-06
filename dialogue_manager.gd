extends CanvasLayer

@onready var dialogue_box = $Control
@onready var dialogue_text = $Control/DialogueText

var current_line: int
var dialogue_lines: Array[String] = []
var is_dialogue_active = false

func _ready() -> void:
	dialogue_box.visible = false
	
	start_dialogue(["Test start text...", 
					"Test ends now..."])

func start_dialogue(lines: Array[String]):
	get_tree().paused = true
	
	is_dialogue_active = true
	dialogue_lines = lines
	current_line = 0
	dialogue_box.visible = true
	dialogue_text.visible = true
	dialogue_text.text = dialogue_lines[current_line]
	
func advance_dialogue():
	if current_line < dialogue_lines.size() - 1:
		current_line += 1
		dialogue_text.text = dialogue_lines[current_line]
	else:
		get_tree().paused = false
		is_dialogue_active = false
		dialogue_box.visible = false
	
func _input(event):
	if not is_dialogue_active:
		return
	if Input.is_action_just_pressed("ui_accept"):
		advance_dialogue()
	
