extends RigidBody2D

var player
var targetPos = Vector2()
var lastPos = Vector2()
@onready var _anim = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var playerData = PlayerData
var canMove = true
var pathFollow
var direction = false
var speed = 1
var Building1Positions
var nameOfSelf
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent().get_parent().get_parent().get_node("Player")
	_anim = $AnimatedSprite2D
	pathFollow = get_tree().get_root().get_node("Node2D/Building/Path2D/PathFollow2D")
	Building1Positions = get_node("/root/Building1Positions")
	nameOfSelf = get_meta("name")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	targetPos = player.global_position+(Vector2.DOWN * 400)+(Vector2.LEFT * 150)
	
	if targetPos.distance_to(lastPos) > 0 and canMove:
		_anim.play("enemy_walking")
		canMove = false
	else:
		_anim.stop()
		canMove = true
		
	lastPos = targetPos
		
	#apply_central_force(self.global_position.direction_to(targetPos) * Vector2(1, 0) * 1200)
	
func patrol_building():
	speed = 1
func can_i_see_the_player():
	if Building1Positions.locations[nameOfSelf] == Building1Positions.locations["player"]:
		return true
	else:
		return false
func _physics_process(delta):
	
	#is the player wearing a tie
	if not playerData.tietoggle:
		#check if the guard can see the player
		if can_i_see_the_player():
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
			else:
				print("walking left")
				#walk left
				direction = not right
			
			#check if the guard has collided with (captured) the player
			
			if get_node("GuardArea").overlaps_area(get_tree().get_root().get_node("Node2D/Player/Area2D")):
				print("You got captured")
				
				#Back to the main scene for you
				get_tree().change_scene_to_file("res://scenes/node_3d.tscn")
				player.onReturnToMainScene(Vector2(0, -1000))
	else:
		#otherwise just patrol like normal
		patrol_building()
	
	
	
	#check if the guard is about to teleport and prevent it
	#check if the guard has reached the bottom
	if pathFollow.progress<10:
		#turn the guard around
		direction = true
	#check if the guard has reached the top of the building
	if pathFollow.progress >= 6270:
		#turn the guard around
		direction = false;
		
		
		
		
		
	#move the guard according to the direction var
	if direction == false:
		pathFollow.progress -= 200 * delta * speed
		
	else:
		pathFollow.progress += 200 * delta * speed
		
	
