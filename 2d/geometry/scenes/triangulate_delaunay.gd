extends Node2D

export(int) var point_count = 500

var graph = Graph.new()


func _ready():
	Random2D.seed = 37
	generate()


func generate():
	graph.clear()

	# Delaunay triangulation and generating complete graph produce identical MST.
	var edges = test_delaunay_mst()
#	var edges = test_complete_graph_mst()  # This is x40 slower for 1000 points

	Debug2D.clear()
	Debug2D.draw_set_filled(false)
	for edge in edges:
		Debug2D.draw_line(edge.a.value, edge.b.value)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			point_count = int(clamp(point_count + 50, 50, 1000))
			generate()
		elif event.button_index == BUTTON_WHEEL_DOWN:
			point_count = int(clamp(point_count - 50, 50, 1000))
			generate()


func generate_points():
	var points = PoolVector2Array([])

	for i in point_count:
		var p = Random2D.point_in_circle(0, 500)
		points.append(p)

	return points


func test_complete_graph_mst():
	var points = generate_points()

	graph = Graph.new()
	var V = []
	for p in points:
		V.push_back(graph.add_vertex(p))

	for i in V.size():
		var a = V[i]
		for j in range(i + 1, V.size()):
			var b = V[j]
			if not graph.has_edge(a, b):
				var w = a.value.distance_to(b.value)
				graph.add_edge(a, b, w)

	return graph.minimum_spanning_tree()



func test_delaunay_mst():
	var points = generate_points()

	var I = Geometry.triangulate_delaunay_2d(points)

	graph = Graph.new()
	var V = []
	for p in points:
		V.push_back(graph.add_vertex(p))

	for idx in range(0, I.size(), 3):
		var tri = [V[I[idx + 0]], V[I[idx + 1]], V[I[idx + 2]]]
		for i in tri.size():
			var a = tri[i]
			for j in range(i + 1, tri.size()):
				var b = tri[j]
				if not graph.has_edge(a, b):
					var w = a.value.distance_to(b.value)
					graph.add_edge(a, b, w)

	return graph.minimum_spanning_tree()
