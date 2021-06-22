extends Node2D

func _ready():
	$UI/Label.text = "Press \"Enter\" to jump and observe Output window in the editor."
	
	var character = preload("res://character.tscn").instance()
	add_child(character)
	
	assert(character.is_in_group("characters"),
			"Character should be assigned to `characters` group (agent.gd).")

	character.id = randi()
	character.team = "Blue"
