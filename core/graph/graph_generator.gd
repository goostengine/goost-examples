class_name GraphGenerator

static func create_grid(p_graph, p_width, p_height, p_scale, p_randomness = 0.6, inverse_weights = false):
	p_graph.clear()

	var grid = []
	for j in p_height:
		var row = []
		for i in p_width:
			var p = Vector2(i * p_scale, j * p_scale)
			p += Random2D.point_in_circle(0, p_scale * p_randomness)
			var v = p_graph.add_vertex(p)
			row.push_back(v)
		grid.push_back(row)

	for row in grid:
		for i in p_width - 1:
			var a = row[i]
			var b = row[i + 1]
			var w = a.value.distance_to(b.value)
			p_graph.add_edge(a, b, -w if inverse_weights else w)

	for j in p_height - 1:
		var row_a = grid[j]
		var row_b = grid[j + 1]

		for i in p_width:
			var a = row_a[i]
			var b = row_b[i]
			var w = a.value.distance_to(b.value)
			p_graph.add_edge(a, b, -w if inverse_weights else w)
