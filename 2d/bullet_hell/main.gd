extends Node2D

const SHOOT_RATE = 0.01
var shooting: InvokeState


func _ready():
	shooting = GoostEngine.invoke(self, "shoot", 0, SHOOT_RATE)


func shoot():
	var bullet = preload("res://bullet.tscn").instance()
	add_child(bullet)
	bullet.global_position = get_viewport_rect().size / 2.0
	bullet.direction = Random2D.direction


func _input(event):
	if event.is_action_pressed("ui_accept"):
		shooting.cancel()
		shooting = GoostEngine.invoke(self, "shoot", 0, SHOOT_RATE)
	if event.is_action_pressed("ui_cancel"):
		shooting.cancel()
