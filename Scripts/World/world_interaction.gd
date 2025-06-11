extends CollisionObject2D
class_name WorldInteraction

signal object_hovered(hovering: bool)

var is_mouse_hovered: bool = false
var is_character_near: bool = false

func _ready():
	mouse_entered.connect(func mouse_hover():
		is_mouse_hovered = true
		object_hovered.emit(true))
	mouse_exited.connect(func mouse_hover():
		is_mouse_hovered = false
		object_hovered.emit(false))

func _input(event: InputEvent) -> void:
	# TODO: controller interactions
	if event.is_action_pressed("player_general_interact") and is_mouse_hovered:
		on_interact()

func on_interact() -> void:
	pass