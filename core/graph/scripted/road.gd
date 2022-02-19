class_name Road extends Graph


func _create_vertex():
	return RoadIntersection.new()


func _create_edge():
	return RoadSegment.new()


func add_intersection(position: Vector2):
	return add_vertex(position)


func add_segment(from, to):
	return add_edge(from, to)


func get_intersections():
	return get_vertices()
