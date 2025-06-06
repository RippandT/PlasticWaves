extends Node

signal play_branch(branch_index: int)

@export var box: ColorRect
var coin: Array[int] = [0,0]

func checked_dialogue_choices(_delay: float, item_name: String, coin_index: int, _give: bool):
	if item_name.to_lower() != "coin":
		return

	coin[coin_index] = 1

func confirm_ending(branch_index: int, item: String, amount: int) -> void:
	var coin_count: int = coin[0] + coin[1]
	
	print("%s: %s" % [item, amount])

	if item.to_lower() != "coin":
		return

	if coin_count >= amount:
		play_branch.emit(branch_index)

func generic_event(delay: float, event: String):
	if delay > 0:
		await get_tree().create_timer(delay).timeout
	
	if event.to_lower() == "change_color":
		box.color = Color.DARK_GOLDENROD
