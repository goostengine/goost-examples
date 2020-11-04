extends Node2D

export(int) var count = 1000

var triangle = [Vector2(), Vector2(), Vector2()]
var point_idx = 0


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		point_idx = wrapi(point_idx + 1, 0, 3)
		triangle[point_idx] = get_global_mouse_position()
		update()


func _draw():
	var c = Color.white
	c.a = 0.1
	draw_colored_polygon(triangle, c)
	for i in count:
		var point = Random2D.point_in_triangle(triangle)
		draw_circle(point, 3, Random.color_hsv(0, 1, 0.5, 0.75, 1))
