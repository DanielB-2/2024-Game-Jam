extends CharacterBody2D


var speed = 500.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


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
		
		$PlayerImage.position.x = 138
		$PlayerImage.position.y = -60.5
		$PlayerImage.scale.x = 1
		$PlayerImage.scale.y = .5
		
	else:
		$CrouchingCollisionShape.disabled = true
		$PlayerNormalCollision.disabled = false
		speed = 500
		$PlayerImage.position.x = 138
		$PlayerImage.position.y = -80.5
		$PlayerImage.scale.x = 1
		$PlayerImage.scale.y = 1
		
		
		

	# Get the input direction and handle the movement/deceleration.


			

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
