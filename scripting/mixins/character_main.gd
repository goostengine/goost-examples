# Press "Edit" button in the inspector to edit all mixins (and manage this one).

# Due to GDScript parse validation checks, we cannot extend `KinematicBody2D`
# directly, and methods must be called using the `owner` property proxy defined
# in `Mixin` class, which points to our real `KinematicBody2D` node.
extends Mixin
#extends KinematicBody2D

const GRAVITY = 980
var velocity = Vector2()


func _ready():
	print("Character is ready (character_main.gd)")


func _physics_process(_delta):
	velocity.y += GRAVITY * _delta
	velocity = owner.move_and_slide(velocity, Vector2.UP)


func jump():
	if owner.is_on_floor():
		velocity.y -= GRAVITY * 0.5
