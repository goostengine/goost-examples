extends Node2D

func _ready():
	# Initialize image container for GIF.
	var image_frames = ImageFrames.new()

	# Generate some frames (simply rotate input image).
	var angle = 0.0
	for i in 32:
		var frame = Image.new()
		frame.load("res://icon.png")
		GoostImage.rotate(frame, angle, false)
		var delay = 0.02
		image_frames.add_frame(frame, delay)
		angle += TAU / 32.0

	# Finally, save GIF to file.
	image_frames.save_gif("res://goost.gif")

	print("GIF is saved to res://goost.gif")

	# Because GIF is saved to `res://` path,
	# it will also be imported by Godot's editor!
