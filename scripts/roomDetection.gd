extends Area2D

var floors = [null, null, null, null, null]
var Building1Positions
var nameOfSelf
# Called when the node enters the scene tree for the first time.
func _ready():
	Building1Positions = get_node("/root/Building1Positions")
	nameOfSelf = get_meta("name")
	for i in range(5):
		floors[i] = get_tree().get_root().get_node("Node2D/Building/StaticBody2D").get_node("Floor" + str(i+1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(5):
		if (self.overlaps_area(floors[i])):
			Building1Positions.locations[nameOfSelf] = i;
			#if user is overlapping 2 floors it will only say it is overlapping the higher floor
			
	print(str(Building1Positions.locations["player"]) +":"+str(Building1Positions.locations["guard1"]))
