extends CollisionObject2D
class_name WorldInteraction

@export var click_event: ClickEvent

var is_mouse_hovered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_entered.connect(func mouse_hover():
		is_mouse_hovered = true)
	mouse_exited.connect(func mouse_hover():
		is_mouse_hovered = true)

func _input(event: InputEvent) -> void:
	if click_event == null:
		return
	
	if event is InputEventMouseButton:
		click_event.on_click()