extends Node2D

enum Type {
	MIN_SPANNING_TREE,
	MAX_SPANNING_TREE,
}
var graph = Graph.new()
export(Type) var type = Type.MIN_SPANNING_TREE
export(int, 10, 100) var grid_step = 100


func _ready():
	# Note that the rendering takes more time than actual graph processing.
	generate()


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		generate()


func generate():
	graph.clear()
	Debug2D.clear()

	# Setup draw parameters.
	var vp_size = get_viewport_rect().size
	var grid_width = max(int((vp_size.x / grid_step) - 1), 2)
	var grid_height = max(int((vp_size.y / grid_step) - 1), 2)

	var ofs = vp_size - Vector2(grid_width, grid_height) * grid_step + Vector2.ONE * grid_step
	ofs *= 0.5
	Debug2D.draw_set_transform(ofs, 0, Vector2.ONE)

	# Generate graph.
	var inverse_weights = false if type == Type.MIN_SPANNING_TREE else true
	GraphGenerator.create_grid(graph, grid_width, grid_height, grid_step, 0.6, inverse_weights)

	# Draw original graph.
	var v_size = grid_step * 0.1 # Vertex circle size.
	var v_color: Color = ProjectSettings.get("debug/draw/2d/color")

	Debug2D.draw_set_line_width(grid_step * 0.025)

	for v in graph.get_vertices():
		Debug2D.draw_circle(v_size, v.value, v_color.darkened(0.6))

	for e in graph.get_edges():
		Debug2D.draw_line(e.a.value, e.b.value, v_color.darkened(0.6))

	# Find MST.
	var tree = graph.minimum_spanning_tree()

	# Draw MST.
	Debug2D.draw_set_color(Color.orange)
	for e in tree:
		Debug2D.draw_line(e.a.value, e.b.value, v_color)
		Debug2D.draw_circle(v_size, e.a.value)
		Debug2D.draw_circle(v_size, e.b.value)
