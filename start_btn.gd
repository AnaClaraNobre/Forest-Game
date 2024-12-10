extends Button


func _on_mouse_entered() -> void:
	$btn_start.modulate.r =0.7
	$btn_start.modulate.g =0.7
	$btn_start.modulate.b =0.7

	pass # Replace with function body.


func _on_mouse_exited() -> void:
	$btn_start.modulate.r =1
	$btn_start.modulate.g =1
	$btn_start.modulate.b =1
	pass # Replace with function body.


func _on_pressed() -> void:
	$btn_start.modulate.r =0.3
	$btn_start.modulate.g =0.3
	$btn_start.modulate.b =0.3
	get_tree().change_scene_to_file("res://tutorial.tscn")
