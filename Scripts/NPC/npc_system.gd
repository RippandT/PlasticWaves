extends CharacterBody2D
class_name NPCSystem

@export var npc_data: NPCData

var is_player_near: bool = false
var is_mouse_hovered: bool = false

func _ready():
	mouse_entered.connect(func mouse_hover():
		is_mouse_hovered = true)
	mouse_exited.connect(func mouse_hover():
		is_mouse_hovered = false)

func _unhandled_input(event: InputEvent) -> void:
	# TODO: controller interactions
	if event.is_action_pressed("player_general_interact") and is_mouse_hovered and is_player_near:
		on_interact()
		return
	
	if event.is_action_released("player_general_interact") and is_mouse_hovered and is_player_near:
		on_release()

func on_interact() -> void:
	print("mouse pressed")
	pass

func on_release() -> void:
	print("mouse released")

func on_item(item: ItemData) -> void:
	print("%s is called by %s" % [item.item_name, self])
	pass

func change_npc_schedule(schedule_id: int) -> void:
	npc_data.npc_status_id = schedule_id