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
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent().get_parent().get_parent().get_node("Player")
	_anim = $AnimatedSprite2D
	pathFollow = get_tree().get_root().get_node("Node2D/Building/Path2D/PathFollow2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	targetPos = player.global_position+(Vector2.DOWN * 400)+(Vector2.LEFT * 150)
	if playerData.tietoggle:
		set_collision_layer_value(2, false)
		set_collision_mask_value(2, false)
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
	else:
		set_collision_layer_value(2, true)
		set_collision_mask_value(2, true)
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
	if targetPos.distance_to(lastPos) > 0 and canMove:
		_anim.play("enemy_walking")
		canMove = false
	else:
		_anim.stop()
		canMove = true
		
	lastPos = targetPos
		
	#apply_central_force(self.global_position.direction_to(targetPos) * Vector2(1, 0) * 1200)
	

func _physics_process(delta):
	#if the guard is walking down the building
	if direction == false:
		pathFollow.progress -= 200 * delta
		#check if the guard has reached the bottom
		if pathFollow.progress<100:
			direction = true
	else:
		pathFollow.progress += 200*delta
		#check if the guard has reached the top of the building
		if pathFollow.progress >= 6100:
			direction = false;
	
	print(pathFollow.progress)
	
