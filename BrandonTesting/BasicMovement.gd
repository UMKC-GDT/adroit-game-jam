extends CharacterBody2D

# Adjust these variables in the inspector to tune the movement feel
@export var speed: float = 300.0
@export var jump_velocity: float = -400.0

# Get the gravity from the project settings (usually set in Project -> Project Settings -> Physics -> 2d)
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
	
func _physics_process(delta: float) -> void:
	# Apply gravity if the character is not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump action
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get input direction and handle movement/deceleration
	# "ui_left" and "ui_right" are default input actions
	var direction: float = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		# Decelerate when no input is received
		velocity.x = move_toward(velocity.x, 0, speed)

	# Move the character and slide along collisions
	move_and_slide()
	
@export var sensitivity: float = .01
var aimOffset: Vector2 = Vector2.ZERO

@export var middlePoint: Node2D
@export var positivePoint: Node2D
@export var negativePoint: Node2D

var angle: float = float(0.0)
@export var lightFieldOfView: float = 10
@export var lightDistance: float = 20.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		aimOffset += event.relative * sensitivity
		
func _process(delta: float) -> void:
	SetAnglePointLocation()
	CheckCollisions()
	
var angleForLookPosition
func SetAnglePointLocation():
	angleForLookPosition = rad_to_deg(aimOffset.angle())
	middlePoint.position = self.position + aimOffset
	positivePoint.position = self.position + aimOffset.normalized().rotated(deg_to_rad(lightFieldOfView)) * lightDistance
	negativePoint.position = self.position +  aimOffset.normalized().rotated(deg_to_rad(-lightFieldOfView)) * lightDistance

@export var platform: Sprite2D
@export var botIntPoint: Node2D
@export var leftIntPoint: Node2D
@export var rightIntPoint: Node2D
@export var topIntPoint: Node2D

func CheckCollisions():
	var scaleX = (platform.scale.x * 100) / 2
	var scaleY = (platform.scale.y * 100 )/ 2

	
	
	var center = platform.global_position
	
	var topLeft = center + Vector2(-scaleX, scaleY)
	var topRight = center + Vector2(scaleX, scaleY)
	var botRight = center + Vector2(scaleX, -scaleY)
	var botLeft = center + Vector2(-scaleX, -scaleY)
	
	var intersection = Geometry2D.segment_intersects_segment(topLeft, topRight, self.position, negativePoint.position)
	if (intersection != null):
		botIntPoint.position = intersection
	
	intersection = Geometry2D.segment_intersects_segment(topRight, botRight, self.position, negativePoint.position)
	if (intersection != null):
		leftIntPoint.position = intersection
	
	intersection = Geometry2D.segment_intersects_segment(botRight, botLeft, self.position, negativePoint.position)
	if (intersection != null):
		rightIntPoint.position = intersection
	
	intersection = Geometry2D.segment_intersects_segment(botLeft, topLeft, self.position, negativePoint.position)
	if (intersection != null):
		topIntPoint.position = intersection	
	#CheckIfPointIsInLight(topLeft, "tl")
	#CheckIfPointIsInLight(topRight, "tr")
	#CheckIfPointIsInLight(botLeft, "bl")
	#CheckIfPointIsInLight(botRight, "tl")
	
	pass

func GetIntersectionOfTwoLines(pointA, pointB, pointC, pointD):
	
	pass

# TODO
# So this will check if a point is in the collision of the light(a pizza slice)
func CheckIfPointIsInLight(point: Vector2, name: String):
	var center = self.position
	var dist = sqrt((point.x - center.x)*(point.x - center.x) + (point.y - center.y)*(point.y - center.y))
	var angle = atan2(point.y- center.y, point.x - center.x)
	
	if (angle < rad_to_deg(aimOffset.angle()) - lightFieldOfView && angle > rad_to_deg(aimOffset.angle()) + lightFieldOfView):
		print("In collision of ", name)
	
	pass
