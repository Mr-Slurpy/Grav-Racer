extends Node

var scene
var current_track
var current_connector
var track_scenes = {}

func _ready():
	scene = get_tree().edited_scene_root

func set_current_track(path):
	if scene == null:
		error("No currently editing scene!")
		return
	current_track = scene.get_node(path)
	if current_track == null:
		error("Path is invalid!")

func set_current_connector(position):
	current_connector = current_track.get_node("connector " + position)

func add_track(type):
	if current_track == null:
		error("No tracks node selected!")
		return
	if current_connector == null:
		error("No connector selected!")
		return
	var track_scene = track_scenes[type]
	if track_scene == null:
		error("Track scene for " + track + " is not set!")
		return
	
	var track = track_scene.instance()
	track.global_transform = current_connector.global_transform
	current_track.get_parent().add_child_below_node(current_track)
	track.set_owner(scene)
	
	current_track = track
	set_current_connector(1)

func add_special(path):
	pass

onready var error_dialog = get_node("ErrorDialog")

func error(msg = "Error in Track Plugin!"):
	error_dialog.dialog_text = msg
	error_dialog.popup_centered(Vector2(1, 1))