extends Area2D



func _on_body_entered(body):
	if body.name == "Player":
		var policy_name = self.name
		if PlayerData.collectPolicy():
			Global.coin_collected.emit(policy_name) #goes into Globa.gd
			Global.policyCollectSound()
