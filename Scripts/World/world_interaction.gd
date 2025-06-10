extends CollisionObject2D
class_name WorldInteraction

signal object_hovered(hovering: bool)

@export var click_event: ClickEvent

var is_mouse_hovered: bool = false

func _ready():
	mouse_entered.connect(func mouse_hover():
		is_mouse_hovered = true
		object_hovered.emit(true))
	mouse_exited.connect(func mouse_hover():
		is_mouse_hovered = false
		object_hovered.emit(false))

func _input(event: InputEvent) -> void:
	if click_event == null:
		return
	
	if event is InputEventMouseButton:
		click_event.on_click()
