extends Control

func _on_button_button_down() -> void:
	# active
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_button_button_up() -> void:
	# inactive
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
