extends RigidBody2D

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var targetPos = player.global_position+(Vector2.DOWN * 400)+(Vector2.LEFT * 150)
	apply_central_force(self.global_position.direction_to(targetPos) * Vector2(1, 0) * 1200)
	
