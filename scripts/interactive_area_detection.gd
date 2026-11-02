extends Node2D

@onready var area = %InteractiveAreaDetection
@onready var IconSprite = $sprite
@export var ItemColor: String = ""
@export var ItemTexture: Texture


func _ready() -> void:
	if not Engine.is_editor_hint():
		IconSprite.texture = ItemTexture
	if not Engine.is_editor_hint():
		IconSprite.texture = ItemTexture
		
		area.body_entered.connect(_on_body_entered)
		area.body_exited.connect(_on_body_exited)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		IconSprite.texture = ItemTexture


func _on_body_entered(_body: Node2D) -> void:
	GlobalVars.isInteractable = true
	GlobalVars.currentFlower = String(ItemColor)

func _on_body_exited(_body: Node2D) -> void:
	GlobalVars.isInteractable = false
	GlobalVars.currentFlower = "none"
