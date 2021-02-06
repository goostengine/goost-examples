extends Sprite

var direction = Vector2()
var speed = 100

func _physics_process(delta):
	position += speed * direction * delta
	rotation = direction.angle() + PI / 2


func _on_notifier_screen_exited():
	queue_free()
