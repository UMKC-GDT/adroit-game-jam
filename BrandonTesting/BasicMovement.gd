extends CharacterBody2D

# Adjust these variables in the inspector to tune the movement feel
@export var speed: float = 300.0
@export var jump_velocity: float = -1000.0

# Get the gravity from the project settings (usually set in Project -> Project Settings -> Physics -> 2d)
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

# Hides the mouse
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
	print(self.position)
	for platform in platforms:
		FindLineIntersectionsWithBox(platform)

@export var platformSize: float

var angleForLookPosition
func SetAnglePointLocation():
	angleForLookPosition = rad_to_deg(aimOffset.angle())
	middlePoint.position = self.position + aimOffset
	positivePoint.position = self.position + aimOffset.normalized().rotated(deg_to_rad(lightFieldOfView)) * lightDistance
	negativePoint.position = self.position +  aimOffset.normalized().rotated(deg_to_rad(-lightFieldOfView)) * lightDistance

@export var platforms: Array[StaticPlatform] = []




# Right now when you give this a 2d sprite representing a platform it finds all points that the light intersects with
# the platforms edges
func FindLineIntersectionsWithBox(platform: StaticBody2D):
	platform.CheckToCreateCollisionBox(global_position, positivePoint.global_position, negativePoint.global_position)
	
	pass
