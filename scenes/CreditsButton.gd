extends Button
const NODE_3D = preload("res://scenes/introScene.tscn")


func _ready():
	pressed.connect(self._button_pressed)

func _button_pressed():
	get_tree().change_scene_to_file("res://scenes/introScene.tscn")
