extends CharacterBody2D

@onready var policy_label = $PolicyLabel

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Access the PlayerData singleton
var playerData = PlayerData

func _physics_process(delta):
	# Add the gravity.
	print(playerData)
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	policy_label.text = "POLICIES: " + str(playerData.policiesHeld)
	
func collect_policy():
	# function called from policy.gd. returns false if not at limit. returns true if at limit
	if playerData.policiesHeld < 4:
		playerData.policiesHeld += 1
		return false
	else:
		return true

func shred_policy():
	# called from shredder.gd
	playerData.policiesHeld = 0
	print("Policies Voided")
