extends TextureRect

var dX = 15
var posy = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x -= dX
	global_position.y = posy
	if global_position.x < -300:
		global_position.x = get_viewport().size.x
		posy = randf_range(50, 250)
		print("Y"+ posy)
		print("X" + dX)
	
