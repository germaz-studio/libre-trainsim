@tool
extends Window

var base_control


func validate():
	var unique_name = $MarginContainer/VBoxContainer/Grid/Input_Unique.text
	unique_name = FileTools.to_valid_filename(unique_name)
	if unique_name.is_empty():
		var notice := preload("empty_popup.tscn").instantiate()
		add_child(notice)
		notice.popup_centered()
		return

	var author_name = $MarginContainer/VBoxContainer/Grid/Input_Author.text
	var display_name = $MarginContainer/VBoxContainer/Grid/Input_Name.text

	create_mod(author_name, unique_name, display_name)
	hide()
	var notice = preload("notice_popup.tscn").instantiate()
	base_control.add_child(notice)
	notice.popup_centered()
	queue_free()


func create_mod(author_name: String, mod_unique_name: String, mod_display_name: String):
	var mod_path = "res://Mods".path_join(mod_unique_name)

	var d = DirAccess.open("res://")
	d.open("res://")
	d.make_dir_recursive(mod_path)
	d.change_dir(mod_path)
	d.make_dir("Environments")
	d.make_dir("Materials")
	d.make_dir("Music")
	d.make_dir("Objects")
	d.make_dir("Persons")
	d.make_dir("RailTypes")
	d.make_dir("SignalTypes")
	d.make_dir("Sounds")
	d.make_dir("Textures")

	var authors = Authors.new()
	authors.developers = [author_name]
	authors.contributors = []
	authors.translators = []
	ResourceSaver.save(mod_path.path_join("authors.tres"), authors, ResourceSaver.FLAG_CHANGE_PATH | ResourceSaver.FLAG_REPLACE_SUBRESOURCE_PATHS)

	var content = ModContentDefinition.new()
	content.unique_name = mod_unique_name
	content.display_name = mod_display_name

	content.environment_folders = [mod_path.path_join("Environments")]
	content.material_folders = [mod_path.path_join("Materials")]
	content.music_folders = [mod_path.path_join("Music")]
	content.object_folders = [mod_path.path_join("Objects")]
	content.persons_folders = [mod_path.path_join("Persons")]
	content.rail_type_folders = [mod_path.path_join("RailTypes")]
	content.signal_type_folders = [mod_path.path_join("SignalTypes")]
	content.sound_folders = [mod_path.path_join("Sounds")]
	content.texture_folders = [mod_path.path_join("Textures")]

	ResourceSaver.save(mod_path.path_join("content.tres"), content, ResourceSaver.FLAG_CHANGE_PATH | ResourceSaver.FLAG_REPLACE_SUBRESOURCE_PATHS)
