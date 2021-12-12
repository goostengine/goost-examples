extends Node2D

func _ready():
	var image_frames = ImageFrames.new()
	# The path could point to filesystem path. If you need to load imported
	# animated texture, use `preload("res://animated.gif")` instead.
	image_frames.load("res://animated.gif") 

	var animated_texture = AnimatedTexture.new()
	animated_texture.frames = image_frames.get_frame_count()

	for i in image_frames.get_frame_count():
		var frame = image_frames.get_frame_image(i)
		var tex = ImageTexture.new()
		tex.create_from_image(frame)

		animated_texture.set_frame_texture(i, tex)
		animated_texture.set_frame_delay(i, image_frames.get_frame_delay(i))

	$sprite.texture = animated_texture
