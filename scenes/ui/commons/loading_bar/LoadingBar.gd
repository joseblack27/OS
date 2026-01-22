extends ProgressBar
class_name LoadingBar

@export var next_scene_path: String = "res://scenes/ui/main/MainOs.tscn"
var progress: Array[float] = []

func _ready():
	ResourceLoader.load_threaded_request(next_scene_path)

func _process(_delta):
	var status = ResourceLoader.load_threaded_get_status(next_scene_path, progress)
	
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			var pct = progress[0] * 100
			value = pct
		ResourceLoader.THREAD_LOAD_LOADED:
			var scene = ResourceLoader.load_threaded_get(next_scene_path)
			get_tree().change_scene_to_packed(scene)
