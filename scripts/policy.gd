extends Area2D

@onready var musicplayer = AudioStreamPlayer2D.new()
@onready var track = load("res://music/collectpolict.wav")

func _on_body_entered(body):
	if body.name == "Player":
		var policy_name = self.name
		if PlayerData.collectPolicy():
			Global.coin_collected.emit(policy_name) #goes into Globa.gd		
			add_child(musicplayer)
			musicplayer.stream = track
			musicplayer.set_max_polyphony(2)
			musicplayer.play()
			await get_tree().create_timer(1.3).timeout
			musicplayer.stop()
			
			
			queue_free() 
