extends Area2D

@onready var policies = $".."

func _on_body_entered(body):
	if body.name == "Player":
		var policy_name = self.name
		if not PlayerData.collectPolicy():
			Global.coin_collected.emit(policy_name) #goes into Globa.gd
			queue_free() 
