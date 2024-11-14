extends HBoxContainer


func _unhandled_input(event):
	if event.is_action_pressed("prototype_activate_multiplayer"):
		show()
