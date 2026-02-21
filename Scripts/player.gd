extends CharacterBody2D

@export var speed := 40.0
@export var maxSpeed := 250.0
@export var airSpeed := 300.0
@export var groundFriction := 1300.0
@export var airFriction := 50.0
@export var jumpVelocity := 430.0
@export var doubleJumpVelocity := 400.0
@export var wallJumpVelocity := 400.0
@export var wallJumpPushOff := 200.0

@onready var rightWallCast: RayCast2D = $RightWallCast
@onready var leftWallCast: RayCast2D = $LeftWallCast

var spawnPosition: Vector2

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var maxFallSpeed := 1200.0

var inputDir := 0.0

var canDoubleJump := true
var canWallJump := true


func _ready() -> void:
	spawnPosition = self.position

func _process(delta: float) -> void:
	getInputDir()
	
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
		if(isMovingRight()):
			self.velocity.x -= groundFriction * delta
		elif(isMovingLeft()):
			self.velocity.x += groundFriction * delta
		
		if(self.velocity.x < 20 and self.velocity.x > -20):
			self.velocity.x = 0
	else:
		# add to speed
		self.velocity.x += speed * inputDir
		# limit speed
		self.velocity.x = limitSpeed(self.velocity.x, maxSpeed)


func doAirMovement(delta: float):
	# Gravity first
	self.velocity.y += gravity * delta
	if(self.velocity.y > maxFallSpeed):
		self.velocity.y = maxFallSpeed
	
	#friction based on direction
	if(isMovingRight()):
		self.velocity.x -= airFriction * delta
	elif(isMovingLeft()):
		self.velocity.x += airFriction * delta
	
	# Add a little speed in air if player is trying to move
	if(wantsToGoRight()):
		self.velocity.x += airSpeed * delta
	elif(wantsToGoLeft()):
		self.velocity.x -= airSpeed * delta


func doJump():
	if(is_on_floor()):
		self.velocity.y = -jumpVelocity
	elif(getDirectionForWallJump() != 0 and canWallJump): #If we have a wall we can jump to
			doWallJump()
			return
	elif(canDoubleJump):
		
		self.velocity.y = -doubleJumpVelocity
		canDoubleJump = false
		
		# Reverse direction if player wants to jump other direction
		if(isMovingRight() and wantsToGoLeft()):
			self.velocity.x = self.velocity.x * -0.8
		elif(isMovingLeft() and wantsToGoRight()):
			self.velocity.x = self.velocity.x * -0.8


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
	var direction = getDirectionForWallJump()
	self.velocity.y = -wallJumpVelocity
	self.velocity.x = -wallJumpPushOff * direction


func limitSpeed(currentSpeed: float, maxSpeed: float):
	if(abs(currentSpeed) > maxSpeed):
		return maxSpeed * inputDir
	return currentSpeed

func getInputDir():
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
