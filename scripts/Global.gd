extends Node

@onready var soundplayer = AudioStreamPlayer2D.new()
@onready var track = load("res://music/collectpolict.wav")

var collected_coins = {}
signal coin_collected

func _ready():
	Global.coin_collected.connect(on_coin_collected)
	add_child(soundplayer)
	soundplayer.stream = track
	soundplayer.set_max_polyphony(2)
	
func _physics_process(delta):
	for coin in get_tree().get_nodes_in_group("Policies"):
		#print(str(collected_coins) + " end")
		if coin.name in collected_coins:
			coin.queue_free()
	if Input.is_action_just_pressed("exitgame"):
		get_tree().quit()

func updateCoinState(coin_id: String, collected: bool):
	collected_coins[coin_id] = collected

func on_coin_collected(index):
	print("hi")
	updateCoinState(index, true)
	
func introSequence():
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/node_3d.tscn")

func policyCollectSound():
	soundplayer.stop()
	soundplayer.play()
