extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player
@onready var phone = $Player/Phone
var index = 1


# Called when the node enters the scene tree for the first time.
var canMove = true

func _ready():
	player.play("walk")
	seq()
	pass

func _process(delta):
	if canMove:
		player.position.x = player.position.x + 5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func seq():
	match index:
		1:
			await get_tree().create_timer(6.6).timeout
			canMove = false
			player.stop()
			index += 1
			seq()
		2:
			player.stop()
			player.play("call")
			await get_tree().create_timer(2.6).timeout
			phone.visible = true
			player.play("call_stable")
			index += 1
			seq()
			
