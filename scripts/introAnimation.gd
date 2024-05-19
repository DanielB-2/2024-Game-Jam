extends Node2D

@onready var camera = $Camera2D
@onready var player = $Player
@onready var phone = $Player/Phone

@onready var message1 = $"Player/Phone/Text Messages/Text1"
@onready var message2 = $"Player/Phone/Text Messages/Text2"
@onready var message3 = $"Player/Phone/Text Messages/Text3"
@onready var message4 = $"Player/Phone/Text Messages/Text4"
@onready var message5 = $"Player/Phone/Text Messages/Text5"
@onready var textmessages = $"Player/Phone/Text Messages"
	
	
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
		3:
			textmessages.visible = true
			message1.visible = true
			await get_tree().create_timer(2.1).timeout
			index += 1
			seq()
		4:
			message2.visible = true
			await get_tree().create_timer(1.6).timeout
			index += 1
			seq()
		5:
			message3.visible = true
			await get_tree().create_timer(3.3).timeout
			index += 1
			seq()
		6:
			message4.visible = true
			await get_tree().create_timer(3.3).timeout
			index += 1
			seq()
		7:
			message5.visible = true
			await get_tree().create_timer(0.6).timeout
			index += 1
			seq()
			
