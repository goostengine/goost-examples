extends GridContainer

export(Texture) var texture setget set_texture


func set_texture(p_texture):
	texture = p_texture

	call_deferred("_update_original", texture)
	call_deferred("_update_preview", texture)
	call_deferred("_update_palette_texture", texture)


func _update_original(p_texture):
	$original.texture = p_texture


func _update_preview(p_texture):
	$preview.texture = p_texture


func _update_palette_texture(p_texture):
	$palette.texture = p_texture


func _on_palette_applied(p_image):
	var tex = ImageTexture.new()
	tex.create_from_image(p_image, 0)

	_update_preview(tex)
