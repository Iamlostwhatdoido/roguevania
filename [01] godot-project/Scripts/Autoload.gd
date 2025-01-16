extends Node2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("kill_game"):
		get_tree().quit()
		get_tree().set_input_as_handled()
