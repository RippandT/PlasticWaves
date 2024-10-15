extends Node
class_name InputDetection

var current_input = "Keyboard and Mouse"

func _unhandled_input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		print("Keyboard and Mouse")
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		print(Input.get_joy_name(event.device))
	
