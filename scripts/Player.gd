extends CharacterBody2D

@onready var policy_label = $PolicyLabel
@onready var voided_label = $voidedLabel
@onready var _sprite = $AnimatedSprite2D
@onready var animation_player = $voidedLabel/AnimationPlayer

var speed = 500.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Access the PlayerData singleton
var playerData = PlayerData

func _ready():
	global_position = playerData.lastEntered
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

		
	if Input.is_action_pressed("crouchKey"):
		$CrouchingCollisionShape.disabled = false
		$PlayerNormalCollision.disabled = true
		print("Shift has been pressed")
		speed = 200
		
	else:
		$CrouchingCollisionShape.disabled = true
		$PlayerNormalCollision.disabled = false
		speed = 500
		
		
		

	# Get the input direction and handle the movement/deceleration.


			

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		if direction < 0:
			_sprite.flip_h = true
		else:
			_sprite.flip_h = false
				
				
		_sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		_sprite.stop()

	move_and_slide()
	policy_label.text = "POLICIES: " + str(playerData.policiesHeld)
	
func onReturnToMainScene(doorPosition):
	# Spawn player at the door position
	print("returned to main scene " + str(doorPosition))
	global_position = doorPosition
	print(global_position)
	
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
	animation_player.play("transition")
	voided_label.visible = true
	await get_tree().create_timer(1).timeout
	voided_label.visible = false
	
