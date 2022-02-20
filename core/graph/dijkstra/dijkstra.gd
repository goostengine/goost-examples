extends Node2D

var graph = Graph.new()
var width = 15
var height = 10
var step = 50

func _ready():
	# Note that the rendering takes more time than actual graph processing.
	generate()


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		generate()


func generate():
	graph.clear()
	Debug2D.clear()
	$camera.position = Vector2(width, height) * step * 0.5

	# Generate graph.
	GraphGenerator.create_grid(graph, width, height, step)

	# Draw original graph.
	var v_size = step * 0.08 # Vertex circle size.
	var v_color: Color = ProjectSettings.get("debug/draw/2d/color")

	# Draw underlying grid graph.
	Debug2D.draw_set_line_width(step * 0.025)
	for v in graph.get_vertices():
		Debug2D.draw_circle(v_size, v.value, v_color.darkened(0.6))
	for e in graph.get_edges():
		Debug2D.draw_line(e.a.value, e.b.value, v_color.darkened(0.6))

	# Find tree
	var root = Random.pick(graph.get_vertices())
	var tree = graph.shortest_path_tree(root)

	Debug2D.draw_set_color(Color.cornflower)
	Debug2D.draw_set_line_width(step * 0.2)
	Debug2D.draw_circle(v_size * 2, root.value)

	# Find arbitrary shortest path.
	var shortest_path = []
	var current = Random.pick(graph.get_vertices())
	while true:
		shortest_path.append(current)
		var previous = tree.backtrace[current]
		if not previous:
			break # Reached source vertex (root).
		Debug2D.draw_line(current.value, previous.value)
		current = previous
	shortest_path.invert()

	if not shortest_path.empty():
		Debug2D.draw_circle(v_size * 2, shortest_path.back().value, Color.cornflower)
		for v in shortest_path:
			Debug2D.draw_circle(v_size, v.value)

	# Draw all paths
	Debug2D.draw_set_color(Color.orange)
	Debug2D.draw_set_line_width(step * 0.025)
	for edge in tree.edges:
		Debug2D.draw_line(edge.a.value, edge.b.value, v_color)
		Debug2D.draw_circle(v_size, edge.a.value)
		Debug2D.draw_circle(v_size, edge.b.value)
