extends Node
class_name CursorSystem

signal send_item(item: ItemData)

var item_on_hand: ItemData
var is_mouse_hovered: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("player_general_interact"):
		item_on_hand = null

func get_item(item: ItemData):
	item_on_hand = item

func send_item_on_hand(callable: Callable) -> void:
	if item_on_hand == null:
		return
		
	callable.call(item_on_hand)
