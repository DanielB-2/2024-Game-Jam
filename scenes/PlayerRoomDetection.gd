extends Area2D

var floors = [null, null, null, null, null]
var Building1Positions

# Called when the node enters the scene tree for the first time.
func _ready():
	Building1Positions = get_node("/root/Building1Positions")
	for i in range(5):
		floors[i] = get_parent().get_parent().get_node("Building/StaticBody2D/Floor" + str(i+1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(5):
		if (self.overlaps_area(floors[i])):
			Building1Positions.playerLocation = i;
		
