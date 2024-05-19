extends Button

@onready var phone = $".."
@onready var player = $"../.."
@onready var instructions = $"../../../Instructions"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	phone.visible = false
	player.visible = false
	instructions.text = "Collect all of the policies in each building without getting caught

"
	await get_tree().create_timer(1.5).timeout
	instructions.text += "Shred policies to void them
	
"
	await get_tree().create_timer(1.5).timeout
	instructions.text += "Take off your tie to disguise
	
"
	await get_tree().create_timer(1.5).timeout
	instructions.text += "Guards can hear. Shift to sneak"
	
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/node_3d.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
