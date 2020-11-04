extends Node2D

export(int) var count = 300

const SIZE = 200.0
const BASE = PoolVector2Array([Vector2(-1, -1), Vector2(1, -1), Vector2(1, 1), Vector2(-1, 1)])
var subject = Transform2D(0, Vector2.ZERO).scaled(Vector2.ONE * SIZE).xform(BASE)

var polygons = []


func _init():
	Random2D.randomize()


func _process(_delta):
		randomize_points()


func randomize_points():
	var pos = get_global_mouse_position()
	var brush = GoostGeometry2D.regular_polygon(32, SIZE * 2)
	brush = Transform2D(0, pos).xform(brush)
	polygons = GoostGeometry2D.clip_polygons(subject, brush)
	update()


func _draw():
	if not polygons.empty():
		var points = Random2D.point_in_polygon(polygons, count)
		for p in points:
			draw_circle(p, 4, Random.color_hsv(0, 1, 1, 1, 1))
	# Per-point version, less efficient, slightly worse distribution:
#	if not polygons.empty():
#		for i in count:
#			var point = Random2D.point_in_polygon(polygons, 1)
#			draw_circle(point, 4, Random.color_hsv(0, 1, 1, 1, 1))
