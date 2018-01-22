tool
extends EditorScenePostImport

func post_import(scene):
	for index in scene.get_child_count():
		var node = scene.get_child(index)
		if node.get_name().begins_with("connector"):
			var connector = Spatial.new()
			connector.transform = node.transform
			connector.set_name(node.get_name())
			node.replace_by(connector)
			node.free()
	return scene