extends RigidBody2D

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player")
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	apply_central_force(self.position.direction_to(player.position) * 100)
	print(self.position, player.position, self.position.direction_to(player.position) * 100)

