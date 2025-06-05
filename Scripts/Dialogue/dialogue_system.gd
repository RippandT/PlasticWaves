extends Node
class_name DialogueSystem

signal dialogue_box_visibility(visible: bool)

signal send_line(line: DialogueLeaf)
signal send_decisions(decisions: Array[DialogueChoice])

signal ask_item(branch_index: int, item: String, amount: int)
signal ask_quest(branch_index: int, quest: String)
signal ask_event(branch_index: int, event: String)

## The dialogue tree to be played
@export var dialogue_tree: DialogueTree

var current_dialogue_tree: DialogueTree
var current_dialogue_index: int = 0

func _ready() -> void:
	if dialogue_tree != null:
		play_dialogue_tree(dialogue_tree)

## Play the dialogue tree
func play_dialogue_tree(tree: DialogueTree) -> void:
	dialogue_tree = tree
	if tree == null:
		dialogue_box_visibility.emit(false)
		return

	current_dialogue_tree = tree
	current_dialogue_index = 0
	display_dialogue(0)
	dialogue_box_visibility.emit(true)

## Play the next line
func next_line() -> void:
	current_dialogue_index += 1
	display_dialogue(current_dialogue_index)

	if current_dialogue_tree.is_branching and current_dialogue_index == current_dialogue_tree.dialogue_branch.dialogue_leaves.size() - 1:
		send_decisions.emit(current_dialogue_tree.dialogue_choices)

## Display the line
func display_dialogue(index: int) -> void:
	#index = clampi(0, 999999, index) # This piece of code is buggy I dunno why; this should prevent an index from going into the negatives
	index = abs(index)

	if index >= current_dialogue_tree.dialogue_branch.dialogue_leaves.size():
	#	dialogue_box_visibility.emit(false)
		print("No more lines")
		return

	send_line.emit(current_dialogue_tree.dialogue_branch.dialogue_leaves[index])

## Make the choice buttons to be deployed
func instantiate_choices() -> void:
	pass

## Try to branch out
func try_branch(branch_index: int) -> void:
	var branch_requirement_type: int = current_dialogue_tree.dialogue_choices[branch_index].dialogue_requirement.dialogue_requirement_type

	match branch_requirement_type:
		0: # None
			play_branch(branch_index)
			return
		1: # Item
			# Check if player has one or more of a particular item, if not then don't play
			var item_needed: String = current_dialogue_tree.dialogue_choices[branch_index].dialogue_requirement.dialogue_requirement_need.get_slice(":", 0)
			var item_quantity: int = int(current_dialogue_tree.dialogue_choices[branch_index].dialogue_requirement.dialogue_requirement_need.get_slice(":", 1))
			ask_item.emit(branch_index, item_needed, item_quantity)
			return
		2: # Event
			# Check if player has triggered a certain event, if not then don't play
			ask_event.emit(branch_index, current_dialogue_tree.dialogue_choices[branch_index].dialogue_requirement.dialogue_requirement_need)
			return
		3: # Quest
			# Check if player has completed a quest, if not then don't play
			ask_quest.emit(branch_index, current_dialogue_tree.dialogue_choices[branch_index].dialogue_requirement.dialogue_requirement_need)
			return
		_:
			print_debug("Branch requirement type does not exist")
			play_branch(branch_index) # This prevents any softlocks created by mistakes in the code
			return

## Play a branch from the current tree
func play_branch(branch_index: int) -> void:
	play_dialogue_tree(current_dialogue_tree.dialogue_choices[branch_index].dialogue_tree)
