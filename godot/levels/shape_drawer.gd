extends StaticBody2D

func _ready() -> void:
	queue_redraw()

func _draw() -> void:
	var collision = get_child(0)
	if get_child(0) is CollisionPolygon2D:
		var colors : PackedColorArray = [Color.WHITE]
		draw_polygon(collision.polygon, colors)
