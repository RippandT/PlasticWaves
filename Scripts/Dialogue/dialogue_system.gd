extends Node
class_name DialogueSystem

signal dialogue_box_visibility(visible: bool)
signal send_line(line: String)
signal send_decisions(decisions: Array[String])

## The dialogue tree to be played
@export var dialogue_tree: DialogueTree

var current_dialogue_tree: DialogueTree
var current_dialogue_index: int = 0

func _ready():
	pass

## Play the dialogue tree
func play_dialogue_tree(tree: DialogueTree):
	if tree == null:
		dialogue_box_visibility.emit(false)
		return

	current_dialogue_tree = tree
	current_dialogue_index = 0
	display_dialogue(current_dialogue_index)
	dialogue_box_visibility.emit(true)


## Play the next line
func next_line() -> void:
	current_dialogue_index += 1
	display_dialogue(current_dialogue_index)

	if current_dialogue_tree.dialogue_tree_branch.is_branching:
		send_decisions.emit(current_dialogue_tree.dialogue_tree_branch.branching_choices)

## Display the line
func display_dialogue(index: int) -> void:
	index = clampi(0, 999999, index)

	if index >= current_dialogue_tree.dialogue_tree_branch.dialogue_leaves.size():
		dialogue_box_visibility.emit(false)
		return

	send_line.emit(current_dialogue_tree.dialogue_tree_branch.dialogue_leaves[index])

## Try to branch out
func try_branching(branch_index: int) -> void:
	var branch_requirement_type: int = current_dialogue_tree.next_branches[branch_index].dialogue_tree_branch.dialogue_requirement.dialogue_requirement_type

	match branch_requirement_type:
		0: # None
			play_dialogue_tree(current_dialogue_tree.next_branches[branch_index])
			return
		1: # Item
			# Check if player has one or more of a particular item, if not then don't play
			return
		2: # Event
			# Check if player has triggered a certain event, if not then don't play
			return
		3: # Quest
			# Check if player has completed a quest, if not then don't play
			return
		_:
			print_debug("Branch requirement type does not exist")
			return