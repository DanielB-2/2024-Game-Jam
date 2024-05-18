extends RigidBody2D

var player
var targetPos = Vector2()
var lastPos = Vector2()
@onready var _anim = $AnimatedSprite2D
var canMove = true
var pathFollow

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent().get_parent().get_parent().get_node("Player")
	_anim = $AnimatedSprite2D
	pathFollow = get_tree().get_root().get_node("Node2D/Building/Path2D/PathFollow2D")


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
	

func _physics_process(delta):
	pathFollow.progress -= 200 * delta;
	print(pathFollow.progress)
	
