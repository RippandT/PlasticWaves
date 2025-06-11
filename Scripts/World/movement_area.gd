extends CollisionObject2D
class_name MovementArea

signal move_player(position: Vector2)

var is_button_held: bool = false
var is_mouse_inside: bool = false
var move_position: Vector2 = Vector2(0, 0)

func _ready():
	mouse_entered.connect(func mouse_hover():
		is_mouse_inside = true)
	mouse_exited.connect(func mouse_hover():
		is_mouse_inside = false)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		is_button_held = (event.is_action_pressed("player_general_interact")) and event.pressed and is_mouse_inside

func _process(_delta: float):
	if is_mouse_inside:
		move_position = get_global_mouse_position()
	if is_button_held:
		move_player.emit(move_position)
