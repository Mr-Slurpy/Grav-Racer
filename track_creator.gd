tool
extends EditorPlugin

var dock

func _enter_tree():
	dock = load("res://addons/Track Creator/TrackEditor.tscn").instance()
	add_control_to_dock(DOCK_SLOT_LEFT_UL, dock)

func _exit_tree():
	remove_control_from_docks(dock)
	dock.free()