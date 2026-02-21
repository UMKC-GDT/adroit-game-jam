extends Sprite2D
class_name StaticPlatform

@export var wasVisible: bool = false

var topLeftPoint: Vector2
var topRightPoint: Vector2
var botLeftPoint: Vector2
var botRightPoint: Vector2

@export var platformSize: float

@export var botIntPointLeftVis: Node2D
@export var leftIntPointLeftVis: Node2D
@export var rightIntPointLeftVis: Node2D
@export var topIntPointLeftVis: Node2D

@export var botIntPointRightVis: Node2D
@export var leftIntPointRightVis: Node2D
@export var rightIntPointRightVis: Node2D
@export var topIntPointRightVis: Node2D

@export var topLeftPointVis: Node2D
@export var topRightPointVis: Node2D
@export var botRightPointVis: Node2D
@export var botLeftPointVis: Node2D


# sets the corner vectors of each point
func _ready() -> void:
	var scaleX = self.scale.x * platformSize
	var scaleY = self.scale.y * platformSize
	
	var center = self.position
	
	botLeftPoint = center + Vector2(-scaleX, scaleY)
	botRightPoint = center + Vector2(scaleX, scaleY)
	topRightPoint = center + Vector2(scaleX, -scaleY)
	topLeftPoint = center + Vector2(-scaleX, -scaleY)
	
	pass

func CheckToCreateCollisionBox(playerPosition: Vector2, positiveLineEndPoint: Vector2, negativeLineEndPoint: Vector2):
	var collisionVertexes = GetCollisionPoints(playerPosition, positiveLineEndPoint, negativeLineEndPoint)
	
	if (collisionVertexes != null && collisionVertexes.size() > 0):
		print("Got it")
		#TODO make the light collision box based off the vertexes that we have
		
	pass
	
# So this will check if the light intercets this box
func GetCollisionPoints(playerPosition: Vector2, positiveLineEndPoint: Vector2, negativeLineEndPoint: Vector2):
	var collisionVertexs : Array[Vector2] = []
	var vertexPoint
	
	# checks if the top left point is in the light
	vertexPoint = CheckIfPointIsInLight(topLeftPoint, playerPosition, positiveLineEndPoint, negativeLineEndPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)
		topLeftPointVis.visible = true	
		topLeftPointVis.position = vertexPoint
	else:
		topLeftPointVis.visible = false
	
	# checks if the top right point is in the light
	vertexPoint = CheckIfPointIsInLight(topRightPoint, playerPosition, positiveLineEndPoint, negativeLineEndPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)
		topRightPointVis.visible = true	
		topRightPointVis.position = vertexPoint
	else:
		topRightPointVis.visible = false
	
	# checks if the bot right point is in the light
	vertexPoint = CheckIfPointIsInLight(botRightPoint, playerPosition, positiveLineEndPoint, negativeLineEndPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)
		botRightPointVis.visible = true	
		botRightPointVis.position = vertexPoint
	else:
		botRightPointVis.visible = false
	
	# checks if the bot left point is in the light
	vertexPoint = CheckIfPointIsInLight(botLeftPoint, playerPosition, positiveLineEndPoint, negativeLineEndPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)
		botLeftPointVis.visible = true	
		botLeftPointVis.position = vertexPoint
	else:
		botLeftPointVis.visible = false
	
	# checks intersection for top point for negative line
	vertexPoint = GetWhereLightIntersectsPlatform(topLeftPoint, topRightPoint, playerPosition, negativeLineEndPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)
		topIntPointRightVis.visible = true	
		topIntPointRightVis.position = vertexPoint
	else:
		topIntPointRightVis.visible = false
			
	#checks intersection for left point for negative line
	vertexPoint = GetWhereLightIntersectsPlatform(topLeftPoint, botLeftPoint, playerPosition, negativeLineEndPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)
		leftIntPointRightVis.visible = true	
		leftIntPointRightVis.position = vertexPoint
	else:
		leftIntPointRightVis.visible = false
			
	#checks intersection for right point for negative line
	vertexPoint = GetWhereLightIntersectsPlatform(topRightPoint, botRightPoint, playerPosition, negativeLineEndPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)
		rightIntPointRightVis.visible = true	
		rightIntPointRightVis.position = vertexPoint
	else:
		rightIntPointRightVis.visible = false
			
	#checks intresection for bot point for negative line
	vertexPoint = GetWhereLightIntersectsPlatform(botLeftPoint, botRightPoint, playerPosition, negativeLineEndPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)
		botIntPointRightVis.visible = true	
		botIntPointRightVis.position = vertexPoint
	else:
		botIntPointRightVis.visible = false
			
	# checks intersection for top point for positive line
	vertexPoint = GetWhereLightIntersectsPlatform(topLeftPoint, topRightPoint, playerPosition, positiveLineEndPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)
		topIntPointLeftVis.visible = true	
		topIntPointLeftVis.position = vertexPoint
	else:
		topIntPointLeftVis.visible = false
			
	#checks intersection for left point for positive line
	vertexPoint = GetWhereLightIntersectsPlatform(topLeftPoint, botLeftPoint, playerPosition, positiveLineEndPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)
		leftIntPointLeftVis.visible = true	
		leftIntPointLeftVis.position = vertexPoint
	else:
		leftIntPointLeftVis.visible = false
			
	#checks intersection for right point for positive line
	vertexPoint = GetWhereLightIntersectsPlatform(topRightPoint, botRightPoint, playerPosition, positiveLineEndPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)
		rightIntPointLeftVis.visible = true	
		rightIntPointLeftVis.position = vertexPoint
	else:
		rightIntPointLeftVis.visible = false
			
	#checks intresection for bot point for positive line
	vertexPoint = GetWhereLightIntersectsPlatform(botLeftPoint, botRightPoint, playerPosition, positiveLineEndPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)
		botIntPointLeftVis.visible = true
		botIntPointLeftVis.position = vertexPoint
	else:
		botIntPointLeftVis.visible = false
	
	pass
	
# Gets the point one line intersects witha another point
func GetWhereLightIntersectsPlatform(point1: Vector2, point2: Vector2, point3: Vector2, point4: Vector2):
	return Geometry2D.segment_intersects_segment(point1, point2, point3, point4)
	
#given a upper position and a lower position checks if the point is in between the two points
func CheckIfPointIsInLight(point: Vector2, playerPosition: Vector2, positivePosition:Vector2, negativePosition:Vector2):
	if (playerPosition.distance_to(point) > playerPosition.distance_to(positivePosition)):
		return null
	
	var positiveAngle = (positivePosition-playerPosition).angle()
	var negativeAngle = (negativePosition-playerPosition).angle()
	var pointAngle = (point - playerPosition).angle()

	if (IsAngleBetween(pointAngle, negativeAngle, positiveAngle)):
		return point
	return null

func IsAngleBetween(a: float, left: float, right: float) -> bool:
	var twopi = TAU
	a = fposmod(a, twopi)
	left = fposmod(left, twopi)
	right = fposmod(right, twopi)
	
	if (left <= right):
		return a >= left and a <= right
	else:
		return a >= left or a <= right
