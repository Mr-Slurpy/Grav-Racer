tool
extends Node

var scene
var current_track
var current_connector
var track_scenes = {}
var long = false

func _ready():
	pass

func set_current_track(path):
	if scene == null:
		error("No currently editing scene!")
		return false
	var track = scene.get_node(path)
	if track == null:
		error("Path is invalid!")
		return false
	if track == scene:
		error("Current track cannot be the root node!")
		return false
	#Update list of connectors if none exist return error!
	current_track = track
	return true

func set_current_connector(position):
	if current_track == null:
		error("No currently selected track!")
		return false
	var connector = current_track.get_node("connector " + position)
	if connector == null:
		error("\"Connector " + position + "\" doesn't exist!\nCheck track scene to make sure it exists!\nProper naming is \"Connector [index]\"")
		return false
	current_connector = connector
	return true

func add_track_type(type):
	var track_scene = track_scenes[type]
	if track_scene == null:
		error("No scene for type \"" + type + "\"")
		return false
	var track = track_scene.instance()
	return add_track(track)

func add_special(res):
	var track_scene = load(res)
	if track_scene == null:
		error("Resource for special track not found!")
		return false
	var track = track_scene.instance()
	return add_track(track)

func add_track(track):
	if scene == null:
		error("No currently open scene detected!")
		return false
	if current_track == null:
		error("No tracks node selected!")
		return false
	if current_connector == null:
		error("No connector selected!")
		return false
	
	track.global_transform = current_connector.global_transform
	current_track.get_parent().add_child_below_node(track, current_track)
	track.set_owner(scene)
	
	current_track = track
	set_current_connector(1)
	
	return true

func delete():
	if scene == null:
		error("No currently open scene detected!")
		return false
	if current_track == null:
		error("No tracks node selected!")
		return false
	
	var index = current_track.get_index()
	if index == 0:
		var new_track = current_track.get_parent()
		current_track.free()
		if new_track == scene:
			current_track = null
		else:
			current_track = new_track
	else:
		pass

func long_toggle(use_long):
	long = use_long

enum TrackType{
	UP, DOWN, LEFT, RIGHT, FORWARD, TILT_LEFT, TILT_RIGHT
}

onready var error_dialog = get_node("ErrorDialog")

func error(msg = "Error in Track Plugin!"):
	error_dialog.dialog_text = msg
	error_dialog.popup_centered(Vector2(1, 1))