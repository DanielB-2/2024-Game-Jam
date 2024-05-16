extends Node

# Singleton instance
static var instance

# Player data
var policiesHeld = 0

func _ready():
	# Set the singleton instance
	instance = self

# Function to collect a policy
func collectPolicy():
	if policiesHeld < 4:
		policiesHeld += 1
		return false
	else:
		return true

# Function to shred policies
func shredPolicies():
	policiesHeld = 0
	print("Policies voided")
