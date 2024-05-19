extends Area2D



func _on_body_entered(body):
	if body.name == "Player":
		var policy_name = self.name
		if PlayerData.collectPolicy():
			Global.coin_collected.emit(policy_name) #goes into Globa.gd
			Global.policyCollectSound()
			
			if (allPoliciesGone()):
				get_tree().change_scene_to_file("res://scenes/node_3d.tscn")

func allPoliciesGone():
	if get_tree().current_scene:
		var scene_name = get_tree().current_scene.get_name()
		if scene_name.find("building") > -1:
			var policies = get_tree().get_nodes_in_group("Policies")
			if policies.is_empty():
				return true
			else:
				return false
	return false

