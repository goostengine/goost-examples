tool
extends GridRect

var points = []
var hovered_point = Vector2()


func _ready():
	origin_centered = true
	origin_axes_visible = true
	
	points.push_back(Vector2(0, 0))
	points.push_back(Vector2(4, -4))
	points.push_back(Vector2(8, 4))
	points.push_back(Vector2(10, 3))
	points.push_back(Vector2(11, -2))
	points.push_back(Vector2(13, -3))
	points.push_back(Vector2(14, -7))


func _on_point_clicked(_point, point_snapped, _local_position):
	points.push_back(point_snapped)
	update()


func _gui_input(event):
	if event is InputEventMouseMotion:
		hovered_point = view_to_point_snapped(event.position)
		update()


func _draw_line(from, to, _color, _width, line):
	var to_draw = true

	# Draw more divisions.
	if int(abs(line.step % 4)) == 0 and line.type == GridRect.LINE_CELL:
		draw_line(from, to, get_color("line_division"), divisions_line_width - 1)
		to_draw = false

	var mp = view_to_point_snapped(get_local_mouse_position())

	# Draw lines intersecting points on the plot.
	var intersected = false
	var intersect_point = Vector2()
	for p in points:
		if (line.axis == GridRect.AXIS_X and p.y == line.step) or \
				(line.axis == GridRect.AXIS_Y and p.x == line.step):
			if mp == p:
				intersect_point = p
				intersected = true
				draw_line(from, to, Color.orange, 3)
				to_draw = false

	# Draw lines under the cursor.
	if (line.axis == GridRect.AXIS_X and mp.y == line.step) or \
			(line.axis == GridRect.AXIS_Y and mp.x == line.step):
		if not intersected and mp != intersect_point:
			var c = Color.cornflower
			c.a = 0.25
			draw_line(from, to, c, 3)
			to_draw = false

	return to_draw


func _draw():
	if points.size() >= 2:
		var grid_points = []
		for point in points:
			grid_points.push_back(point_to_view(point))
		for i in grid_points.size() - 1:
			draw_line(grid_points[i], grid_points[i + 1], Color.cornflower, 5, true)

	for point in points:
		draw_circle(point_to_view(point), 8, Color.darkblue)

	var c = Color.black
	c.a = 0.25
	draw_circle(point_to_view(hovered_point), 8, c)
