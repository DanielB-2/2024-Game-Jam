extends Area2D

@export var target_room : PackedScene
@onready var _sprite = $Sprite2D
var playerInsideArea = false
var playerData = PlayerData

func _on_body_entered(body):
	if body.name == "Player":
		playerInsideArea = true
		body.toggleSpaceIcon()
		set_process_input(true)

func _on_body_exited(body):
	if body.name == "Player":
		playerInsideArea = false
		body.toggleSpaceIcon()
		set_process_input(false)

func _input(event):
	if playerInsideArea and event.is_action_pressed("action"):
		_sprite.play("dooropen")
		await get_tree().create_timer(0.6).timeout
		PlayerData.currentBuilding=get_meta("building_number")
		changeScene()

func changeScene():
	get_tree().change_scene_to_packed(target_room)
	playerData.lastEntered = global_position
	print(name)
	print(target_room)
