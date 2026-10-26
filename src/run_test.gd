extends Node

func _ready():
	print("Running full simulated load...")
	Root.mobile_version = true
	var track = "res://Worlds/Tutorials/Tutorials.tscn"
	var scenario = "res://Worlds/Tutorials/scenarios/The Basics.tres"
	Root.current_track = track
	Root.current_scenario = scenario
	Root.selected_route = ""
	Root.selected_time = 0
	Root.selected_train = "res://Trains/JFR1/JFR1-Grey.tscn"
	Root.EasyMode = false
	
	print("Loading track PackedScene...")
	var scene = load(track) as PackedScene
	print("Instancing track PackedScene...")
	var world = scene.instantiate()
	print("Adding world to tree...")
	get_tree().root.add_child(world)
	get_tree().current_scene = world
	print("Successfully loaded world: ", world.name)
	print("Waiting 10 frames...")
	for i in range(10):
		await get_tree().idle_frame
		print("Frame ", i, " completed. Player pos: ", world.player.position)
	print("Test complete successfully!")
	get_tree().quit(0)
