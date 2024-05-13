extends Node

var doorInfo = {}  # Dictionary to store door information (scene name and position)
var enteredDoor

func _ready():
	# Set up door information (example)
	doorInfo["Door1"] = { "scene": "res://scenes/building1.tscn", "position": Vector2(100, 100) }
	doorInfo["Door2"] = { "scene": "res://scenes/building2.tscn", "position": Vector2(200, 200) }
	# Add other doors...

func onDoorEntered(doorName):
	# Store the scene information and door position
	var sceneInfo = doorInfo[doorName]
	var scene = sceneInfo["scene"]
	var doorPosition = sceneInfo["position"]
	enteredDoor = doorName
	
	# Save player state (position, etc.) if needed
	
	# Load the corresponding scene
	get_tree().change_scene_to_file(scene)

func onReturnToMainScene():
	# Retrieve the stored door position
	var doorPosition = doorInfo[enteredDoor]["position"]
	
	# Spawn player at the door position
	# Example: spawnPlayerAtPosition(doorPosition)
