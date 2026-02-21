extends Sprite2D

var topLeftPoint: Vector2
var topRightPoint: Vector2
var botLeftPoint: Vector2
var botRightPoint: Vector2

@export var platformSize: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scaleX = self.scale.x * platformSize
	var scaleY = self.scale.y * platformSize
	
	var center = self.position
	
	botLeftPoint = center + Vector2(-scaleX, scaleY)
	botRightPoint = center + Vector2(scaleX, scaleY)
	topRightPoint = center + Vector2(scaleX, -scaleY)
	topLeftPoint = center + Vector2(-scaleX, -scaleY)
	
	var collisionVertexes: PackedVector2Array
		
	collisionVertexes.append(botLeftPoint)
	print(botLeftPoint)
	collisionVertexes.append(botRightPoint)
	print(botRightPoint)
	collisionVertexes.append(topRightPoint)
	print(topRightPoint)
	collisionVertexes.append(topLeftPoint)
	print(topLeftPoint)

	var collider = CollisionPolygon2D.new()
	collider.polygon = collisionVertexes
	add_child(collider)
	print("added collider")
