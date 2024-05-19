extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player
var index = 1


# Called when the node enters the scene tree for the first time.


func _ready():
	player.play("walk")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match index:
		1:
			player.position.x = player.position.x + 5
			await get_tree().create_timer(6.6).timeout
			player.stop()
			index += 1
