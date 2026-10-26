class_name ExportTrack

static func export_editor_track(track_name: String, export_path: String) -> String:
	var editor_directory = jSaveManager.get_setting("editor_directory_path", "user://editor/")
	var mod_path = editor_directory.path_join(track_name)
	export_path = export_path.path_join(track_name)

	var directory := DirAccess.open("res://")
	directory.open("user://")
	directory.make_dir_recursive(export_path)
	directory.change_dir(export_path)

	var packer = PCKPacker.new()
	var ok = packer.pck_start(export_path.path_join(track_name) + ".pck")
	if ok != OK:
		LTSLogger.err("Error creating %s!" % export_path.path_join(track_name) + ".pck", null)
		return "Error creating %s!" % export_path.path_join(track_name) + ".pck"

	var files = get_files_in_directory(mod_path)
	var errors = ""
	for file in files:
		ok = packer.add_file(file.replace(editor_directory, "res://Mods/"), file)
		if ok != OK:
			LTSLogger.err("Could not add file %s to pck!" % file, null)
			errors += "\nCould not add file %s to pck!" % file

	ok = packer.flush(true)
	if ok != OK:
		LTSLogger.err("Could not flush pck!", null)
		return "Could not flush pck!"
	ok = directory.copy(mod_path.path_join("content.tres"), export_path.path_join("content.tres"))
	if ok != OK:
		LTSLogger.err("Unable to copy content.tres to mod folder!", "ExportTrack")
	return "Track exported to the addons folder." + errors


static func get_files_in_directory(path: String) -> Array:
	var files = []
	var dir = DirAccess.open("res://")
	if dir.open(path) != OK:
		return []

	dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	var file_name = dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			files.append_array(get_files_in_directory(path.path_join(file_name)))
		else:
			files.append(path.path_join(file_name))
		file_name = dir.get_next()
	return files
