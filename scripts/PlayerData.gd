extends Node

# singleton i think
static var instance

# Player data
var policiesHeld = 0

func _ready():
	instance = self

func collectPolicy():
	if policiesHeld < 4:
		policiesHeld += 1
		return false
	else:
		return true

func shredPolicies():
	policiesHeld = 0
	print("Policies voided")
