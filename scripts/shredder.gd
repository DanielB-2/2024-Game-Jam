extends Area2D

@onready var player = $"."
@onready var _sprite = $Sprite2D
@onready var soundplayer = AudioStreamPlayer2D.new()
@onready var soundplayer2 = AudioStreamPlayer2D.new()
@onready var shredSound = load("res://assets/sounds/policyShred.mp3")
@onready var voidSound = load("res://assets/sounds/voidedImpact.mp3")

var theBody

var playerInsideArea = false

func _ready():
	soundplayer.stream = shredSound
	add_child(soundplayer)
	soundplayer.set_max_polyphony(2)
	soundplayer2.stream = voidSound
	add_child(soundplayer2)
	soundplayer2.set_max_polyphony(2)
	soundplayer2.volume_db = 5

func _on_body_entered(body):
	if body.name == "Player":
		playerInsideArea = true
		theBody = body
		theBody.toggleSpaceIcon()
		set_process_input(true)

func _on_body_exited(body):
	if body.name == "Player":
		playerInsideArea = false
		theBody.toggleSpaceIcon()
		set_process_input(false)

func _input(event):
	if playerInsideArea and event.is_action_pressed("action"):
		shredPolicies()
		

func shredPolicies():
	_sprite.play("shred")
	theBody.shred_policy()
	await get_tree().create_timer(0.4).timeout
	soundplayer2.stop()
	soundplayer2.play()
	await get_tree().create_timer(0.3).timeout
	soundplayer.stop()
	soundplayer.play()
	await get_tree().create_timer(0.6).timeout
	_sprite.stop()
