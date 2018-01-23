tool
extends EditorPlugin

var dock

func _enter_tree():
	dock = preload("res://addons/Track Creator/TrackEditor.tscn").instance()
	
	dock.set("scene", get_tree().edited_scene_root)
	connect("scene_changed", self, "_update_scene")
	
	add_control_to_dock(DOCK_SLOT_LEFT_UL, dock)

func _update_scene(scene):
	dock.set("scene", scene)

func _exit_tree():
	remove_control_from_docks(dock)
	dock.free()