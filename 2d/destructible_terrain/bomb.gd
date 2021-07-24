class_name Bomb extends RigidBody2D

signal exploded(pos)

export var fuse = 2.0

func _process(delta):
	fuse -= delta
	modulate.s = range_lerp(fuse, 0.0, 2.0, 1, 0.25)
	if fuse <= 0.0:
		emit_signal("exploded", global_position)
		queue_free()
