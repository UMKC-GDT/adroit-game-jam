extends CharacterBody2D

@export var speed := 40.0
@export var maxSpeed := 250.0

@export var airSpeed := 300.0
@export var max_air_speed: float = 300.0
@export var air_accel: float = 800.0
@export var air_drag: float = 400.0
@export var turnaround_multiplier: float = 2.5

@export var groundFriction := 1300.0
@export var airFriction := 50.0
@export var jumpVelocity := 250.0
@export var jumpConstantForce := 10.0
@export var maxJumpHold := 0.35
@export var doubleJumpVelocity := 400.0
@export var wallJumpVelocity := 400.0
@export var wallJumpPushOff := 200.0
@export var wallFallingGravity := 50.0
@export var footStepTimerReset = 0.428
@export var footStepTimer = 0
@export var animationHandler: Node2D

@onready var rightWallCast: RayCast2D = $RightWallCast #IMPORTANT: Both check on Layer 12
@onready var leftWallCast: RayCast2D = $LeftWallCast

@export var starting_present: bool

@onready var flashlight: SimpleFlashlight = $SpriteLight/SimpleFlashlight

var spawnPosition: Vector2

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var maxFallSpeed := 1200.0

var inputDir := 0.0

var canDoubleJump := false
var canWallJump := true

var jumpHeldLength := 0.0
var canJump := true

@export var hasLight = true

var sprite: AnimatedSprite2D
var armSprite: Sprite2D

var dead: bool = false

func _ready() -> void:
	spawnPosition = self.position
	
	print("PLAYER: " + str(starting_present))
	
	flashlight.set_starting_light(starting_present)
	
	#NOTE: Both SpriteLight and SpriteNolight NEED to start off as invisible. This code below will decide which to activate.
	
	if(hasLight):
		pass
	else:
		sprite = $SpriteNolight
		flashlight.process_mode = Node.PROCESS_MODE_DISABLED
		
	var soundManager:sound_manager = get_tree().root.get_node("GameManager").get_node("SoundManager")
	if (soundManager != null):
		soundManager.UpdateSettings($PlayerSoundManager/EmmiterGroundJump)


func _process(delta: float) -> void:
	if dead:
		self.velocity.x = 0
		self.velocity.y = 0


func _physics_process(delta: float) -> void:
	getInputDir(delta)
	animationHandler.faceSprite()
	animationHandler.animateSprite()


	if(Input.is_action_pressed("jump")):
		if(canJump):
			jumpHeldLength += delta
		
		# Limit length it can be held
		if(jumpHeldLength >= maxJumpHold):
			jumpHeldLength = maxJumpHold
			canJump = false
		doJump()
	elif(Input.is_action_just_released("jump")):
		canJump = false
		jumpHeldLength = 0
	
	if(self.is_on_floor()):
		canJump = true
		doGroundMovement(delta)
	else:
		doAirMovement(delta)
	
	move_and_slide()


func doGroundMovement(delta: float):
	if(inputDir == 0):
		# subtract/add friction based on direction of movement
		if(isMovingRight()):
			self.velocity.x -= groundFriction * delta
		elif(isMovingLeft()):
			self.velocity.x += groundFriction * delta
		
		if(self.velocity.x < 20 and self.velocity.x > -20):
			self.velocity.x = 0
	else:
		playFootStepSound(delta)
		# add to speed
		self.velocity.x = speed * inputDir
		# limit speed
		self.velocity.x = limitSpeed(self.velocity.x, maxSpeed)


func doAirMovement(delta: float):
	
	var current_accel = air_accel if inputDir != 0 else air_drag
	var target_speed = inputDir * max_air_speed
	
	# Apply Gravity
	self.velocity.y += gravity * delta
	if(self.velocity.y > maxFallSpeed):
		self.velocity.y = maxFallSpeed
	# If player is against a wall slow their fall
	if(rightWallCast.is_colliding() or leftWallCast.is_colliding()):
		if(self.velocity.y < 0): # If player still has vertical momentum we dont want to cancel it
			pass
		else:
			self.velocity.y = wallFallingGravity
	
	# Friction based on direction
	if(isMovingRight()):
		self.velocity.x -= airFriction * delta
		
	elif(isMovingLeft()):
		self.velocity.x += airFriction * delta
		
	if inputDir != 0 and sign(inputDir) != sign(self.velocity.x):
		current_accel *= turnaround_multiplier
	
	self.velocity.x = move_toward(self.velocity.x, target_speed, current_accel * delta)


func doJump():
	if(self.is_on_floor()):
		groundJump()
		$PlayerSoundManager/EmmiterGroundJump.play()
	elif(getDirectionForWallJump() != 0 and canWallJump): # Prioritize wall jump over double jump
		doWallJump()
	else:
		airJump()


func groundJump():
	animationHandler.playJump()
	self.velocity.y -= jumpVelocity


func airJump():
	# Apply upward force if player is still holding jump
	if(jumpHeldLength > 0 and jumpHeldLength < maxJumpHold):
		self.velocity.y -= jumpConstantForce 
	elif(canDoubleJump):
		self.velocity.y = -doubleJumpVelocity
		
		# Reverse direction if player wants to jump other direction
		if(isMovingRight() and wantsToGoLeft()):
			self.velocity.x = self.velocity.x * -0.8
		elif(isMovingLeft() and wantsToGoRight()):
			self.velocity.x = self.velocity.x * -0.8
			
		canDoubleJump = false


func getDirectionForWallJump(): # 1 = right, -1 = left, 0 is none
	if(rightWallCast.is_colliding() and leftWallCast.is_colliding()):
		var distanceFromRight = abs(rightWallCast.get_collider().position.x - self.postion.x)
		var distanceFromLeft = abs(leftWallCast.get_collider().position.x - self.postion.x)
		
		if(distanceFromLeft > distanceFromRight):
			return 1
		elif(distanceFromLeft < distanceFromRight):
			return -1
		else:
			return 0
		
	elif(rightWallCast.is_colliding()):
		return 1
	elif(leftWallCast.is_colliding()):
		return -1 
	else:
		return 0

func doWallJump():
	animationHandler.playWallJump()
	var direction = getDirectionForWallJump()
	self.velocity.y = -wallJumpVelocity
	self.velocity.x = -wallJumpPushOff * direction


func limitSpeed(currentSpeed: float, maxSpeed: float):
	if(abs(currentSpeed) > maxSpeed):
		return maxSpeed * inputDir
	return currentSpeed

func getInputDir(delta:float):
	if(Input.is_action_pressed("right")):
		inputDir = 1.0
		
	elif(Input.is_action_pressed("left")):
		inputDir = -1.0
		
	else:
		inputDir = 0


func isMovingRight():
	return self.velocity.x > 0

func isMovingLeft():
	return self.velocity.x < 0

func isMoving():
	return self.velocity.x != 0


func wantsToGoRight():
	return inputDir == 1

func wantsToGoLeft():
	return inputDir == -1

func wantsToGo():
	return inputDir != 0


func kill():
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED

func giveFlashlight():
	hasLight = true
	animationHandler.giveFlashlight()


func takeFlashlight():
	hasLight = false
	animationHandler.takeFlashlight()
	
func playFootStepSound(delta: float):
	if footStepTimer <= 0:
		if self.is_on_floor():
			$PlayerSoundManager/EmmiterFootsteps.play()
			footStepTimer = footStepTimerReset
	footStepTimer -= delta
