extends Control

@export var loading_bar: TextureProgressBar
@export var percentage_label: Label

var scene_path: String
var progress: Array
var update: float = 0.0

func _ready() -> void:
	scene_path = LevelSwitch.scene_path
	ResourceLoader.load_threaded_request(scene_path)
	
func _process(delta: float) -> void:
	ResourceLoader.load_threaded_get_status(scene_path, progress)
	
	if (progress[0] > update):
		update = progress[0]
	if(loading_bar.value < update):
		loading_bar.value += update * delta
	percentage_label.text = str(int(update * 100.0))+ " %"
	
	if(loading_bar.value >= 1.0):
		get_tree().change_scene_to_packed(
			ResourceLoader.load_threaded_get(scene_path)
		)
	
