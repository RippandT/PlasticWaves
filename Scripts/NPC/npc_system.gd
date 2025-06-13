extends CharacterBody2D
class_name NPCSystem

signal start_dialogue(dialogue: DialogueTree)
signal ask_for_item_on_hand(callable)

@export var npc_data: NPCData
@export var npc_schedule: Array[NPCSchedule]

var is_player_near: bool = false
var is_mouse_hovered: bool = false

func _ready():
	# TODO: Add initialization for textures, animations, and a bunch of other stuff

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
	if npc_schedule[npc_data.npc_status_id] == null:
		printerr("NPC Schedule is not initialized.")
		return
	if npc_schedule[npc_data.npc_status_id].schedule_dialogue_tree == null:
		return
	
	start_dialogue.emit(npc_schedule[npc_data.npc_status_id].schedule_dialogue_tree)

func on_release() -> void:
	ask_for_item_on_hand.emit(on_item)

func on_item(item: ItemData) -> void:
	pass

func change_npc_schedule(schedule_id: int) -> void:
	npc_data.npc_status_id = schedule_id