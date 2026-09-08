extends StaticBody2D
class_name RiverSegment


func create(top_left: Vector2, top_right: Vector2, bottom_right: Vector2, bottom_left: Vector2):
	var polygon: PackedVector2Array
	polygon.append(top_left)
	polygon.append(top_right)
	polygon.append(bottom_right)
	polygon.append(bottom_left)
	$Polygon2D.polygon = polygon
	$LeftWallCollision.shape.a = bottom_left #	$LeftWallCollision.shape = $LeftWallCollision.shape.duplicate() would be necessary but the alternative is to set "Local to Scene" in the Resource of the two collision nodes
	$LeftWallCollision.shape.b = top_left
	$RightWallCollision.shape.a = bottom_right
	$RightWallCollision.shape.b = top_right
