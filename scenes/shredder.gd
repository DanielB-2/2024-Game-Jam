extends Area2D

@onready var player = $"."

var theBody

var playerInsideArea = false

func _on_body_entered(body):
	if body.name == "Player":
		playerInsideArea = true
		theBody = body
		set_process_input(true)

func _on_body_exited(body):
	if body.name == "Player":
		playerInsideArea = false
		set_process_input(false)

func _input(event):
	if playerInsideArea and event.is_action_pressed("action"):
		shredPolicies()

func shredPolicies():
	theBody.shred_policy()

