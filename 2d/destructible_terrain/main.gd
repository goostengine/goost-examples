extends Node2D

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			var bomb = preload("bomb.tscn").instance()
			add_child(bomb)
			bomb.global_position = get_global_mouse_position()
			bomb.connect("exploded", self, "_on_bomb_exploded")


func _on_bomb_exploded(pos):
	var explosion = PolyCircle2D.new()
	explosion.operation = PolyNode2D.OP_DIFFERENCE
	explosion.radius = 64
	$Terrain/CollisionShape/Boundary.add_child(explosion)
	explosion.global_position = pos
