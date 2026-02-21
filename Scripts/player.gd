extends CharacterBody2D

@export var speed := 40.0
@export var maxSpeed := 250.0
@export var airSpeed := 100.0
@export var groundFriction := 1300.0
@export var airFriction := 100.0
@export var jumpVelocity := 430.0

var gravity = -ProjectSettings.get_setting("physics/2d/default_gravity")
var maxFallSpeed := 1200.0

var inputDir := 0.0

var canDoubleJump := true


func _process(delta: float) -> void:
	# check left right input
	if(Input.is_action_pressed("right")):
		inputDir = 1.0
	elif(Input.is_action_pressed("left")):
		inputDir = -1.0
	else:
		inputDir = 0
		
	# check all other inputs
	if(Input.is_action_just_pressed("jump")):
		doJump()


func _physics_process(delta: float) -> void:
	if(self.is_on_floor()):
		canDoubleJump = true
		doGroundMovement(delta)
	else:
		doAirMovement(delta)
	
	move_and_slide()


func doGroundMovement(delta: float):
	if(inputDir == 0):
		# subtract/add friction based on direction of movement
		if(self.velocity.x > 0):
			self.velocity.x -= groundFriction * delta
		elif(self.velocity.x < 0):
			self.velocity.x += groundFriction * delta
		
		if(self.velocity.x < 20 and self.velocity.x > -20):
			self.velocity.x = 0
	else:
		# add to speed
		self.velocity.x += speed * inputDir
		# limit speed
		self.velocity.x = limitSpeed(self.velocity.x, maxSpeed)


func doAirMovement(delta: float):
	self.velocity.y -= gravity * delta
	if(self.velocity.y > maxFallSpeed):
		self.velocity.y = maxFallSpeed
	
	if(self.velocity.x > 0):
		self.velocity.x -= airFriction * delta
	elif(self.velocity.x < 0):
		self.velocity.x += airFriction * delta
	
	if(inputDir == 1):
		self.velocity.x += airSpeed * delta
	elif(inputDir == -1):
		self.velocity.x -= airSpeed * delta


func doJump():
	if(is_on_floor()):
		self.velocity.y = -jumpVelocity # Negative is up for some reason
	elif(canDoubleJump):
		self.velocity.y = -jumpVelocity
		canDoubleJump = false
		
		if(isMovingRight() and wantsToGoLeft()):
			self.velocity.x = self.velocity.x * -1
		elif(isMovingLeft() and wantsToGoRight()):
			self.velocity.x = self.velocity.x * -1

func limitSpeed(currentSpeed: float, max: float):
	if(abs(currentSpeed) > max):
		return maxSpeed * inputDir
	return currentSpeed

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
