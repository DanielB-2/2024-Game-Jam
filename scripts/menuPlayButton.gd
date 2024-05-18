extends Button
const NODE_3D = preload("res://scenes/node_3d.tscn")


func _ready():
	pressed.connect(self._button_pressed)

func _button_pressed():
	get_tree().change_scene_to_file("res://scenes/node_3d.tscn")
