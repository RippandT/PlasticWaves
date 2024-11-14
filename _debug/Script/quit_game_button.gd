extends Button

func _ready() -> void:
	# Lambda function to quit the game
	button_down.connect(func(): get_tree().quit())
