extends RigidBody2D

var player
var targetPos = Vector2()
var lastPos = Vector2()
@onready var collision = $CollisionShape2D
@onready var soundplayer = AudioStreamPlayer2D.new()
@onready var bgMusic = load("res://music/building.mp3")
@onready var bgMusicChase = load("res://music/chase.mp3")
@onready var playerData = PlayerData
@onready var _sprite_2d = $AnimatedSprite2D
var hasNotSetMusic = true
var canMove = true
var pathFollow
var direction = false
var speed = 1
var Building1Positions
var nameOfSelf
var right
var heard = "no"
@onready var building = get_tree().get_root()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(soundplayer)
	soundplayer.autoplay = true
	bgMusic.loop = true
	bgMusicChase.loop = true
	soundplayer.stream = bgMusic
	soundplayer.play()
	
	player = get_parent().get_parent().get_parent().get_parent().get_node("Player")
	pathFollow = get_tree().get_root().get_node(str(get_tree().current_scene.name) + "/Building/Path2D/PathFollow2D")
	Building1Positions = get_node("/root/Building1Positions")
	nameOfSelf = get_meta("name")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	targetPos = player.global_position+(Vector2.DOWN * 400)+(Vector2.LEFT * 150)
	if targetPos.distance_to(lastPos) > 0 and canMove:
		canMove = false
	else:
		canMove = true
		
	lastPos = targetPos
	
	if playerData.tietoggle:
		playerData.exposure += 1
	else:
		playerData.exposure -= 1
		
	#apply_central_force(self.global_position.direction_to(targetPos) * Vector2(1, 0) * 1200)
	
func patrol_building():
	speed = 1
func can_i_see_the_player():

	if not playerData.tietoggle:
		if Building1Positions.locations[nameOfSelf] == Building1Positions.locations["player"]:
			return true
		else:
			return false
	elif playerData.tietoggle:
		if playerData.exposed:
			if Building1Positions.locations[nameOfSelf] == Building1Positions.locations["player"]:
				return true
			else:
				return false
		patrol_building()

func can_i_hear_the_player():
	if Building1Positions.locations[nameOfSelf] == Building1Positions.locations["player"] + 1:
		return "down"
	elif Building1Positions.locations[nameOfSelf] == Building1Positions.locations["player"]-1:
		return "up"
	else:
		#either no, or the guard should be seeing the player on the same floor
		return "no"
		
func _physics_process(delta):
	if not playerData.shifting:
		heard = can_i_hear_the_player()
	else:
		heard = "no"
		speed = 1
	#is the player wearing a tie
	#if not playerData.tietoggle:
		#check if the guard can see the player
	if can_i_see_the_player():
		
		print("can be seen")
		if soundplayer.stream != bgMusicChase:
			soundplayer.stop()
			soundplayer.stream = bgMusicChase
			soundplayer.play()
		
		#if the guard can see the player
		speed = 2
		var right
		#figure out which way is left and which is right based on the floor number
		if (Building1Positions.locations[nameOfSelf]%2 == 0):
			right = true
			#up is right
			print(right)
		else:
			#down is right
			right = false
			print(right)
				
			
			#figure out which direction to the player and then go that way
			if self.global_position.x-player.global_position.x < 0:
				print("walking right")
				#walk right
				direction = right
				_sprite_2d.flip_h = false
			else:
				print("walking left")
				#walk left
				direction = not right
				_sprite_2d.flip_h = true
				
			
		#check if the guard has collided with (captured) the player
		
		# can i feel the player
		if get_node("GuardArea").overlaps_area(get_tree().get_root().get_node(str(get_tree().current_scene.name) + "/Player/Area2D")):
			print("You got captured")
			
			#Back to the main scene for you
			get_tree().change_scene_to_file("res://scenes/node_3d.tscn")
			player.onReturnToMainScene(Vector2(0, -1000))
	
	elif heard == "up":
		#run up and investigate
		direction = true
		speed = 2
	elif heard == "down":
		#run down and investigate
		direction = false
		speed = 2
	#else:
		#otherwise just patrol like normal
		#patrol_building()
		
	if (Building1Positions.locations[nameOfSelf]%2 == 0):
		if direction == true:
			_sprite_2d.flip_h = false
		else:
			_sprite_2d.flip_h = true
	else:
		if direction == true:
			_sprite_2d.flip_h = true
		else:
			_sprite_2d.flip_h = false
	print(direction)
	if soundplayer.stream != bgMusic:
		soundplayer.stop()
		soundplayer.stream = bgMusic
		soundplayer.play()
	#check if the guard is about to teleport and prevent it
	#check if the guard has reached the bottom
	if pathFollow.progress<10:
		#turn the guard around
		direction = true
	#check if the guard has reached the top of the building
	if pathFollow.progress >= 6270:
		#turn the guard around
		direction = false
		#_sprite_2d.flip_h = not _sprite_2d.flip_h
		
		
		
		
		
	#move the guard according to the direction var
	if direction == false:
		pathFollow.progress -= 200 * delta * speed
		
	else:
		pathFollow.progress += 200 * delta * speed
