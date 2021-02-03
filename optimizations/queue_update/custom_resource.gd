class_name CustomResource extends Resource

export var value = 37 setget set_value

func set_value(p_value):
	value = p_value
	emit_changed()
