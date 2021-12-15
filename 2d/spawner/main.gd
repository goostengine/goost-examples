extends Node2D

export(bool) var random_offset = false
export(bool) var random_time_step = false


func _on_spawner_finished():
	print("Spawner finished emission")


func _on_node_spawned(node):
	if random_time_step:
		$Spawner2D.step = rand_range(1.0, 3.0)
	if random_offset:
		node.position += Random2D.point_in_circle(0, 32)
