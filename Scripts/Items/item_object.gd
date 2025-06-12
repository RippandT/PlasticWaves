extends TextureRect
class_name ItemObject

# Triggers a display to display the info of the item.
signal display_item_info(item_name: String, item_description: String)
# Triggers a display to not display the info of the item. Is undisplay even a word?
signal undisplay_item_info
# Sends the item to another script.
signal send_item(item: ItemData)

@export var item_data: ItemData

var original_position: Vector2

var is_mouse_hovered: bool = false
var is_item_grabbed: bool = false

func _ready() -> void:
	if item_data == null:
		print("Item Data hasn't been initialized.")
		queue_free()
		return
	
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT

	original_position = position
	texture = item_data.item_icon

	mouse_entered.connect(func mouse_hover():
		is_mouse_hovered = true
		display_item_info.emit(item_data.item_name, item_data.item_description)
		send_item.emit(item_data))

	mouse_exited.connect(func mouse_hover():
		is_mouse_hovered = false
		undisplay_item_info.emit())

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		is_item_grabbed = event.is_action_pressed("player_general_interact") and is_mouse_hovered
		#override_original_position(position)

	if is_item_grabbed == false:
		position = original_position

func _process(_delta) -> void:
	if is_item_grabbed:
		position = get_global_mouse_position()# - (position - get_global_mouse_position())

func override_original_position(new_position: Vector2) -> void:
	original_position = new_position