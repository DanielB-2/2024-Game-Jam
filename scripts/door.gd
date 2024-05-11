extends Area2D

@export var target_room : PackedScene

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		set_process_input(true)

func _on_body_exited(body):
	if body.name == "CharacterBody2D":
		set_process_input(false)

func _input(event):
	if event.is_action_pressed("up"):
		changeScene()

func changeScene():
	get_tree().change_scene_to_packed(target_room)
