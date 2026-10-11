extends TextureButton

func _ready() -> void:
	if(SaveSystem.get_var("Completion") == null):
		# self.disabled = true
		pass

func _on_pressed():
	if(SaveSystem.get_var("Completion") == null):
		# self.disabled = true
		GlobalVars.save.emit()
		SaveSystem.save()
		print("Doesn't exist. Made save.")
	else:
		SaveSystem.get_var("Completion")
		var data = SaveSystem.get_var("Completion:oneCompleted")
		print(data)
		'''
		GlobalVars.save.emit()
		SaveSystem.save()
		print("Doesn't exist. Made save.")''' # Use to make a save