extends Node

@onready var soundplayer = AudioStreamPlayer2D.new()
@onready var track = load("res://music/collectpolict.wav")

var collected_coins = {}
signal coin_collected

var completedBuildings = {
	"building1": false,
	"building2": false,
	"building3": false,
	"building4": false,
}

func _ready():
	Global.coin_collected.connect(on_coin_collected)
	add_child(soundplayer)
	soundplayer.stream = track
	soundplayer.set_max_polyphony(2)
	
func _physics_process(delta):
	checkForWin()
	for coin in get_tree().get_nodes_in_group("Policies"):
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
	print("Played sound")
	
func checkIfAllPoliciesCollected():
	if get_tree().current_scene:
		# best line of code ive ever written => vv
		if get_tree().current_scene.name == "building1" or get_tree().current_scene.name == "building2" or get_tree().current_scene.name == "building3" or get_tree().current_scene.name == "building4":
			if get_tree().get_nodes_in_group("Policies").is_empty():
				#print(str(get_tree().current_scene.name) + " rhrsrys")
				completedBuildings[get_tree().current_scene.name] = true
func checkForWin():
	for building in completedBuildings.keys():
		if (completedBuildings[building] == false):
			return false
	get_tree().change_scene_to_file("res://scenes/WinScreen.tscn")
