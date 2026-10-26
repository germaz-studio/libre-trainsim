extends Node

func _ready():
	print("TEST_SCENE: _ready called!")
	await get_tree().create_timer(0.5).timeout
	print("TEST_SCENE: Setting up Play Menu simulation")
	var play_menu = preload("res://Data/UI/play_menu.tscn").instantiate()
	add_child(play_menu)
	play_menu.selected_track = "res://Worlds/Tutorials/Tutorials.tscn"
	play_menu.selected_scenario = "res://Worlds/Tutorials/scenarios/The Basics.tres"
	play_menu.selected_route = ""
	play_menu.selected_time = 0
	play_menu.selected_train = "res://Trains/JFR1/JFR1-Grey.tscn"
	print("Calling load_game()...")
	play_menu.load_game()
	print("load_game() called. Waiting for world to instance...")
	for i in range(100):
		await get_tree().idle_frame
	print("Finished 100 frames! Current scene: ", get_tree().current_scene.name)
	get_tree().quit(0)
