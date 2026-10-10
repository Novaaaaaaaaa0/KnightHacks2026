extends TextureButton

func _on_pressed():
	if(SaveSystem.get_var("Completion") == null):
		self.disabled = true
	else:
		SaveSystem.get_var("Completion")
		print("exists.")
		'''
		UpdateSave.save.emit()
		SaveSystem.save()
		print("Doesn't exist. Made save.")''' # Use to make a save