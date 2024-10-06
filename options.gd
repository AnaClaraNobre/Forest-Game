extends Button


func _on_mouse_entered() -> void:
	$options.modulate.r =0.7
	$options.modulate.g =0.7
	$options.modulate.b =0.7

	pass # Replace with function body.


func _on_mouse_exited() -> void:
	$options.modulate.r =1
	$options.modulate.g =1
	$options.modulate.b =1
	pass # Replace with function body.


func _on_pressed() -> void:
	$options.modulate.r =0.3
	$options.modulate.g =0.3
	$options.modulate.b =0.3
	pass # Replace with function body.
