extends CharacterBody2D

@onready var policy_label = $PolicyLabel
@onready var voided_label = $voidedLabel
@onready var _sprite = $AnimatedSprite2D
@onready var animation_player = $voidedLabel/AnimationPlayer
@onready var hideaction = $PolicyLabel3
@onready var hideactionimg = $PolicyBoard3/PolicyImage
@onready var space_label = $spaceLabel

@onready var tieGood = load("res://assets/tie.png")
@onready var tieBad = load("res://assets/hide.png")

@onready var collision = $PlayerNormalCollision

var speed = 500.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# singleton
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


	_sprite.animation = "walk_notie" if playerData.tietoggle else "walk"
	hideactionimg.texture = tieGood if playerData.tietoggle else tieBad
	hideaction.text = "SHOW" if playerData.tietoggle else "HIDE"
			

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		if direction < 0:
			_sprite.flip_h = true
		else:
			_sprite.flip_h = false
				
				
		_sprite.play("walk_notie" if playerData.tietoggle else "walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		_sprite.stop()

	move_and_slide()
	policy_label.text = str(playerData.policiesHeld)
	
	if Input.is_action_just_pressed("tietoggle"):
		playerData.tietoggle = !playerData.tietoggle
	
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
	await get_tree().create_timer(1.5).timeout
	voided_label.visible = false
	
func toggleSpaceIcon():
	space_label.visible = not space_label.visible
