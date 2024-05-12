extends Area2D

var playerInsideArea = false

func _on_body_entered(body):
	if body.name == "Player":
		playerInsideArea = true
		set_process_input(true)

func _on_body_exited(body):
	if body.name == "Player":
		playerInsideArea = false
		set_process_input(false)

func _input(event):
	if playerInsideArea and event.is_action_pressed("action"):
		changeScene()

func changeScene():
	get_tree().change_scene_to_file("res://scenes/node_3d.tscn")

