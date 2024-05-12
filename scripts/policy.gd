extends Area2D

@onready var player = $"."

func _on_body_entered(body):
	if body.name == "Player":
		var atLimit = body.collect_policy()
		if not atLimit:
			queue_free()
