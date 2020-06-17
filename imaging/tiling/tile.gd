extends Node2D

enum Tile {
	REPEAT,
	FLIP_X,
	FLIP_Y,
	FLIP_XY
}
enum Method {
	COUNT,
	COVER
}

export(Texture) var texture setget set_texture
export var count := Vector2(1, 1) setget set_count
export var size := Vector2() setget set_size
export(Method) var method = Method.COUNT setget set_method
export(Tile) var mode = Tile.REPEAT setget set_mode


func set_texture(p_texture):
	texture = p_texture
	call_deferred("render")


func set_count(p_count):
	count = p_count
	call_deferred("render")


func set_size(p_size):
	size = p_size
	if size.x <= 0:
		size.x = 1
	if size.y <= 0:
		size.y = 1
	call_deferred("render")


func set_method(p_method):
	method = p_method
	call_deferred("render")


func set_mode(p_mode):
	mode = p_mode
	call_deferred("render")


func render():
	var input_image = texture.get_data()

	var output_image
	match method:
		Method.COUNT:
			output_image = GoostImage.repeat(input_image, count, mode)
		Method.COVER:
			output_image = GoostImage.tile(input_image, size, mode)

	var tex = ImageTexture.new()
	tex.create_from_image(output_image)
	$sprite.texture = tex
