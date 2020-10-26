extends Node2D

enum Type {
	CIRCLE,
	RING,
}
export(Type) var type = Type.CIRCLE setget set_type
export var count := 500 setget set_count
export var min_radius := 0.0 setget set_min_radius
export var max_radius := 0.0 setget set_max_radius


func set_type(p_type):
	type = p_type
	call_deferred("spawn")


func set_count(p_count):
	count = p_count
	call_deferred("spawn")


func set_min_radius(p_min_radius):
	min_radius = p_min_radius
	call_deferred("spawn")


func set_max_radius(p_max_radius):
	max_radius = p_max_radius
	call_deferred("spawn")


func _ready():
	randomize()
	if max_radius <= 0.0:
		# Fit screen size.
		max_radius = get_viewport().size.y / 2
		# Make sure sprites are not clipped by viewport.
		max_radius -= preload("res://icon.png").get_size().length()
	if min_radius <= 0.0:
		min_radius = max_radius / 2
	spawn()


func spawn():
	for child in get_children():
		if child is Sprite:
			child.queue_free()
	for i in count:
		var goost = preload("res://goost.tscn").instance()
		add_child(goost)
		# Spawn a sprite at random position within a circle radius.
		var point = Vector2()
		match type:
			Type.CIRCLE:
				point = GoostGeometry2D.rand_point_in_circle(max_radius)
			Type.RING:
				point = GoostGeometry2D.rand_point_in_ring(min_radius, max_radius)
		goost.global_position = point
