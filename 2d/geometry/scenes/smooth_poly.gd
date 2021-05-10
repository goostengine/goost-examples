extends Node2D

export var closed = false
export var visible_vertices = true
export(float, 1.0, 3.0, 0.5) var line_width = 1.5
export(float, 0.0, 1.0, 0.1) var alpha = 0.5
export(float) var density = 10.0

var points = PoolVector2Array()
var points_processed = PoolVector2Array()

enum SmoothType {
	APPROXIMATE,
	INTERPOLATE
}
var smooth_type = SmoothType.APPROXIMATE


func _input(event):
	if event is InputEventKey and event.pressed:
		match event.scancode:
			KEY_F1:
				smooth_type = SmoothType.APPROXIMATE
				_process_points()
			KEY_F2:
				smooth_type = SmoothType.INTERPOLATE
				_process_points()
			KEY_F3:
				closed = not closed
				_process_points()
	elif event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			if Input.is_key_pressed(KEY_P):
				density += 0.1
			else:
				alpha = clamp(alpha + 0.05, 0.0, 1.0)
			_process_points()
		elif event.button_index == BUTTON_WHEEL_DOWN:
			if Input.is_key_pressed(KEY_P):
				density -= 0.1
			else:
				alpha = clamp(alpha - 0.05, 0.0, 1.0)
			_process_points()

	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var pos = get_global_mouse_position()
		pos.x = int(pos.x)
		pos.y = int(pos.y)
		points.push_back(pos)
		_process_points()


func _process_points():
	if closed and points.size() >= 3:
		if smooth_type == SmoothType.APPROXIMATE:
			points_processed = GoostGeometry2D.smooth_polygon_approx(points, 5)
		elif smooth_type == SmoothType.INTERPOLATE:
			points_processed = GoostGeometry2D.smooth_polygon(points, density, alpha)
	else:
		if smooth_type == SmoothType.APPROXIMATE:
			points_processed = GoostGeometry2D.smooth_polyline_approx(points, 4)
		elif smooth_type == SmoothType.INTERPOLATE:
			points_processed = GoostGeometry2D.smooth_polyline(points, density, alpha)
	update()


func draw_points(p_points, color):
	if not closed:
		if p_points.size() >= 2:
			draw_polyline(p_points, color, line_width, true)
	else:
		if p_points.size() >= 3:
			draw_colored_polygon(p_points, color)
	if visible_vertices:
		var color_v = color
		color_v.v += 0.5
		for p in p_points:
			draw_circle(p, 3, color_v)


func _draw():
	match smooth_type:
		SmoothType.APPROXIMATE:
			draw_points(points, Color.orange)
			draw_points(points_processed, Color.cornflower)
		SmoothType.INTERPOLATE:
			draw_points(points_processed, Color.cornflower)
			draw_points(points, Color.orange)
