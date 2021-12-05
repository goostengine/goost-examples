extends Node2D


func _process(_delta):
	var points = []

	for c in $points.get_children():
		points.push_back(c.global_position)

	Debug2D.clear()

	Debug2D.draw_region(GoostGeometry2D.bounding_rect(points).grow(32), Color(1, 1, 1, 0.05))

	Debug2D.draw_set_color(Color.orange)
	Debug2D.draw_set_filled(true)

	for i in points.size():
		var from = points[i]
		var to = points[(i + 1) % points.size()]

		var radius = 8.0
		var length = (to - from).length()
		var offset = radius / length

		Debug2D.draw_arrow(from, to, Color.orange, 1, Vector2(10, 10), offset)
		Debug2D.draw_circle(radius, from)

	Debug2D.capture()

	Debug2D.draw_set_filled(true)
	for i in points.size():
		Debug2D.draw_text(str(i), points[i] + Vector2(0, -16))
		Debug2D.capture()


func _input(event):
	if event.is_action_pressed("ui_left"):
		Debug2D.get_capture().draw_prev()
	elif event.is_action_pressed("ui_right"):
		Debug2D.get_capture().draw_next()
