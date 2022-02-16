extends Node2D

func _ready():
	var road = Road.new()

	var a = road.add_intersection(Vector2(0, 0))
	var b = road.add_intersection(Vector2(100, 100))

	var s = road.add_segment(a, b)
	assert(road.has_edge(a, b))

	for x in road.get_intersections():
		print("Intersection: ", x.value)

	assert(a is RoadIntersection)
	assert(s is RoadSegment)

	print(a.has_lights())
	print(s.is_slippery())
