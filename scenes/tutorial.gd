extends CanvasLayer

func _input(event: InputEvent) -> void:
	if(Input.is_action_just_pressed("Interaction") or Input.is_action_just_pressed("pause")):
		visible = false
		$"../flowerCounter".visible = true
	pass
