extends Node2D

func _ready():
	$Asteroid1.apply_central_impulse(Vector2(120, 70))
	$Asteroid2.apply_central_impulse(Vector2(70, 120))
