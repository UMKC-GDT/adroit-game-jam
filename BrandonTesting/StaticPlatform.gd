extends StaticBody2D
class_name StaticPlatform

@export var reversed: bool = false
@export var sprite: Sprite2D
var polySprite: Polygon2D
var collider: CollisionPolygon2D

var topLeftPoint: Vector2
var topRightPoint: Vector2
var botLeftPoint: Vector2
var botRightPoint: Vector2

@export var platformSizeX: float
@export var platformSizeY: float

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
	var scaleX = sprite.scale.x * platformSizeX
	var scaleY = sprite.scale.y * platformSizeY
	
	var center = sprite.global_position
	
	botLeftPoint = center + Vector2(-scaleX, scaleY)
	botRightPoint = center + Vector2(scaleX, scaleY)
	topRightPoint = center + Vector2(scaleX, -scaleY)
	topLeftPoint = center + Vector2(-scaleX, -scaleY)
	
	sprite.hide()
	pass

func CheckToCreateCollisionBox(playerPosition: Vector2, positiveLineEndPoint: Vector2, negativeLineEndPoint: Vector2):
	var collisionVertexes = GetCollisionPoints(playerPosition, positiveLineEndPoint, negativeLineEndPoint)
	
	if (collider != null):
		remove_child(collider)
		collider = null
		remove_child(polySprite)
		
	if (collisionVertexes != null && collisionVertexes.size() > 0):
		collisionVertexes = PackedVector2Array(SortPoints(collisionVertexes))
		collider = CollisionPolygon2D.new()
		polySprite = Polygon2D.new()
		collider.polygon = collisionVertexes
		polySprite.polygon = collisionVertexes
		polySprite.texture = sprite.texture
		
		add_child(collider)
		add_child(polySprite)
	pass


func SortPoints(points: Array[Vector2]) -> Array[Vector2]:
	if (points.size() < 3):
		return points
	var c = Vector2.ZERO
	for p in points: 
		c += p
	c /= points.size()
	
	points.sort_custom(func(a,b):
		return(a-c).angle() < (b-c).angle()
		)
	return points
	
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
	
	# checks if the play is in the box and will add a vertex at the player position is in the box
	var boxPoints = PackedVector2Array([topLeftPoint, topRightPoint, botRightPoint, botLeftPoint])
	if Geometry2D.is_point_in_polygon(playerPosition, boxPoints):
		collisionVertexs.append(playerPosition)
		
	if Geometry2D.is_point_in_polygon(positiveLineEndPoint, boxPoints):
		collisionVertexs.append(positiveLineEndPoint)
	if Geometry2D.is_point_in_polygon(negativeLineEndPoint, boxPoints):
		collisionVertexs.append(negativeLineEndPoint)
	
	vertexPoint = GetWhereLightIntersectsPlatform(positiveLineEndPoint, negativeLineEndPoint, topLeftPoint, topRightPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)

	vertexPoint = GetWhereLightIntersectsPlatform(positiveLineEndPoint, negativeLineEndPoint, topRightPoint, botRightPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)

	vertexPoint = GetWhereLightIntersectsPlatform(positiveLineEndPoint, negativeLineEndPoint, botRightPoint, botLeftPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)

	vertexPoint = GetWhereLightIntersectsPlatform(positiveLineEndPoint, negativeLineEndPoint, botLeftPoint, topLeftPoint)
	if (vertexPoint != null):
		collisionVertexs.append(vertexPoint)
	return collisionVertexs
	
# Gets the point one line intersects witha another point
func GetWhereLightIntersectsPlatform(point1: Vector2, point2: Vector2, point3: Vector2, point4: Vector2):
	return Geometry2D.segment_intersects_segment(point1, point2, point3, point4)

func GetWhereLightIntersectsCircle(point1: Vector2, point2: Vector2, circleCenter: Vector2, radius: float):
	return Geometry2D.segment_intersects_circle(point1, point2, circleCenter, radius)
	
#given a upper position and a lower position checks if the point is in between the two points
func CheckIfPointIsInLight(point: Vector2, playerPosition: Vector2, positivePosition:Vector2, negativePosition:Vector2):
	var closestPoint = Geometry2D.get_closest_point_to_segment(point, positivePosition, negativePosition)
	if (playerPosition.distance_to(point) > playerPosition.distance_to(closestPoint)):
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
		
