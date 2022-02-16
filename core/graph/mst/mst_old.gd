extends Node2D

const VERTEX_COUNT = 50
var graph = Graph.new()


func _ready():
	draw_graph()


func draw_graph():
	graph.clear()

	for i in VERTEX_COUNT:
		var p = Random2D.point_in_circle(0, 500)
		graph.add_vertex(p)

	generate_from_complete_graph()

	Debug2D.clear()

	for v in graph.get_vertex_list():
		Debug2D.draw_circle(8, v.value)

	var edges = graph.get_edge_list()
	for e in edges:
		Debug2D.draw_line(e.a.value, e.b.value)


func generate_from_complete_graph():
	var vertices = graph.get_vertex_list()

	for i in range(0, vertices.size()):
		var a = vertices[i]
		for j in range(i + 1, vertices.size()):
			var b = vertices[j]
			if a.value.distance_to(b.value) < 200:
				graph.add_edge(a, b)

	var edges = graph.get_edge_list()

	while graph.get_edge_count() > 1000:
		var e = Random.choice(edges)
		if not is_instance_valid(e):
			continue
		if e.a.get_neighbor_count() == 1 or e.b.get_neighbor_count() == 1:
			continue
		graph.remove_edge(e)

#	edges = graph.get_edge_list()
#
#	for i in range(0, edges.size()):
#		var e1 = edges[i]
#		for j in range(i + 1, edges.size()):
#			var e2 = edges[j]
#
#			if not is_instance_valid(e1):
#				continue
#			if not is_instance_valid(e2):
#				continue
#
#			if Geometry.segment_intersects_segment_2d(e1.a.value, e1.b.value, e2.a.value, e2.b.value) != null:
#				graph.remove_edge(Random.choice([e1, e2]))


func generate_path():
	var vertices = graph.get_vertex_list()
	var p = Random.choice(vertices)

	var visited = {}

	for i in 25:
		var a = p
		var b = get_vertex_in_radius(graph, a, visited, 200)
		visited[b] = true
		if b == null:
			continue

#		var skip = false
#		for e in graph.get_edge_list():
#			if Geometry.segment_intersects_segment_2d(a.value, b.value, e.a.value, e.b.value) != null:
#				skip = true
#				break
#		if skip:
#			continue
		p = b

		var w = a.value.distance_to(b.value)
		graph.add_edge(a, b, w)


func get_vertex_in_radius(graph, vertex, exclude, radius):
	for v in graph.get_vertex_list():
		if v in exclude:
			continue
		if v.value.distance_to(vertex.value) < radius:
			return v
	return null


func _input(event):
	if event.is_action_pressed("ui_accept"):
		draw_graph()
