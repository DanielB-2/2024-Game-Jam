extends CharacterBody2D

@onready var policy_label = $PolicyLabel
@onready var voided_label = $voidedLabel
@onready var _sprite = $AnimatedSprite2D
@onready var animation_player = $voidedLabel/AnimationPlayer
@onready var hideaction = $PolicyLabel3
@onready var hideactionimg = $PolicyBoard3/PolicyImage
@onready var space_label = $spaceLabel
@onready var progress_bar = $PolicyBoard4/ProgressBar

var hasNotCrouched = true

@onready var nums = [
	$"PolicyBoard5/Node2D/num1",
	$"PolicyBoard5/Node2D/num2",
	$"PolicyBoard5/Node2D/num3",
	$"PolicyBoard5/Node2D/num4"
]

@onready var buildingsDone = Global.completedBuildings

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
		PlayerData.shifting = true
		
	else:
		$CrouchingCollisionShape.disabled = true
		$PlayerNormalCollision.disabled = false
		speed = 500
		PlayerData.shifting = false
		
		
	

	# Get the input direction and handle the movement/deceleration.
	var index = 4
	for building in buildingsDone.keys():
		var comp = buildingsDone[building]
		if index - 1 < nums.size() and comp:
			print("hello")
			nums[nums.size() - index].visible = true
		index -= 1
	if playerData.shifting:
		_sprite.animation = "crouch_notie" if playerData.tietoggle else "crouch"
	else:
		_sprite.animation = "walk_notie" if playerData.tietoggle else "walk"
		hasNotCrouched = true
		
	hideactionimg.texture = tieGood if playerData.tietoggle else tieBad
	hideaction.text = "SHOW" if playerData.tietoggle else "HIDE"
	
	if progress_bar.value >= 750:
		PlayerData.exposed = true
	else:
		PlayerData.exposed = false
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		if direction < 0:
			_sprite.flip_h = true
		else:
			_sprite.flip_h = false
				
				
		_sprite.play("crouch_stable" if playerData.shifting and !hasNotCrouched else "crouch_stable_notie" if playerData.shifting and !hasNotCrouched and playerData.tietoggle else "crouch" if playerData.shifting and hasNotCrouched else "crouch-notie" if playerData.shifting and playerData.tietoggle and hasNotCrouched else "walk_notie" if playerData.tietoggle else "walk")
		hasNotCrouched = false
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		_sprite.stop()

	move_and_slide()
	policy_label.text = str(playerData.policiesHeld)
	
	if Input.is_action_just_pressed("tietoggle"):
		playerData.tietoggle = !playerData.tietoggle
	
func onReturnToMainScene(doorPosition):
	# Spawn player at the door position
	global_position = doorPosition
	
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
	Global.checkIfAllPoliciesCollected()
	
func toggleSpaceIcon():
	space_label.visible = not space_label.visible


func _on_exposure_tick_timeout():
	if not (PlayerData.currentBuilding == 0):
		if BuildingDifficulties.difficulties[str(PlayerData.currentBuilding)]["canBeExposed"]:
			if playerData.tietoggle == true:
				progress_bar.value += 1
			else:
				progress_bar.value -= 1
