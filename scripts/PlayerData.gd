extends Node

# Singleton instance
static var instance

# Player data
var policiesHeld = 0
var lastEntered = Vector2(-100,0)
var tietoggle = false

var exposed = false
var shifting = false
var currentBuilding = 0

func _ready():
	# Set the singleton instance
	instance = self

# Function to collect a policy
func collectPolicy():
	if policiesHeld < 4:
		policiesHeld += 1
		return true
	else:
		return false

# Function to shred policies
func shredPolicies():
	policiesHeld = 0
	print("Policies voided")
