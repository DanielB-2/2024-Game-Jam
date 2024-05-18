extends Node

var collected_coins = {}
signal coin_collected

func _ready():
	Global.coin_collected.connect(on_coin_collected)

func _physics_process(delta):
	for coin in get_tree().get_nodes_in_group("Policies"):
		#print(str(collected_coins) + " end")
		if coin.name in collected_coins:
			coin.queue_free()

func updateCoinState(coin_id: String, collected: bool):
	collected_coins[coin_id] = collected

func on_coin_collected(index):
	print("hi")
	updateCoinState(index, true)
	
func introSequence():
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/node_3d.tscn")
