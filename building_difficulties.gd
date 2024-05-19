extends Node

var difficulties = {
	"1": {"canHear": false, "canBeExposed": false, "canSwitchTieInFrontOfGuard": true, "canRun": false},
	"2": {"canHear": true, "canBeExposed": true, "canSwitchTieInFrontOfGuard": true, "canRun": false},
	"3": {"canHear": true, "canBeExposed": true, "canSwitchTieInFrontOfGuard": true, "canRun": true},
	"4": {"canHear": true, "canBeExposed": true, "canSwitchTieInFrontOfGuard": false, "canRun": true}
	}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
