extends Node
class_name DialogueSystem

signal dialogue_box_visibility(visible: bool)

signal send_line			(line: DialogueLeaf)
#signal send_decisions		(decisions: Array[DialogueChoice])
signal send_button_decisions(button_decisions: Array[Button])
#signal send_event			(event: Array[DialogueEvent])
signal dialogue_is_ending

signal ask_item				(branch_index: int, item: String, amount: int)
signal ask_quest			(branch_index: int, quest: String)
signal ask_event			(branch_index: int, event: String)

signal event_item			(delay: float, item_name, amount: int, is_give: bool)
signal event_quest			(delay: float, quest, is_give: bool)
signal event_trigger		(delay: float, event: String)
signal event_animation		(delay: float, animation_name: String, play_backwards: bool)

## The dialogue tree to be played
@export var dialogue_tree: DialogueTree

var current_dialogue_tree: DialogueTree
var current_dialogue_index: int = 0

var current_dialogue_choices: Array[DialogueChoice]

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
	current_dialogue_index = -1
	next_line()
	dialogue_box_visibility.emit(true)

## Play the next line
func next_line() -> void:
	display_dialogue(current_dialogue_index + 1)
	check_dialogue_branch_end()
	play_events(current_dialogue_tree.dialogue_branch.dialogue_leaves[current_dialogue_index].dialogue_events)

## Display the line
func display_dialogue(index: int) -> void:
	#index = clampi(0, 999999, index) # This piece of code is buggy I dunno why; this should prevent an index from going into the negatives
	index = abs(index)

	if index >= current_dialogue_tree.dialogue_branch.dialogue_leaves.size():
	#	dialogue_box_visibility.emit(false)
		print("No more lines")
		return

	current_dialogue_index = index
	send_line.emit(current_dialogue_tree.dialogue_branch.dialogue_leaves[index])

## Checks if it's the end of the branch, and do some actions if it is
func check_dialogue_branch_end() -> void:
	## Is it the end of the dialogue branch?
	if current_dialogue_index < current_dialogue_tree.dialogue_branch.dialogue_leaves.size() - 1:
		return
	
	## Does the current tree have branches?
	if !current_dialogue_tree.is_branching:
		# Display end button
		dialogue_is_ending.emit()
		return
	
	print(current_dialogue_tree.dialogue_choices)

	## Does the tree have branches of its own?
	if current_dialogue_tree.dialogue_choices.size() > 0:
		current_dialogue_choices = current_dialogue_tree.dialogue_choices
	
	instantiate_choices(current_dialogue_choices)

## Make the choice buttons to be deployed
func instantiate_choices(decisions: Array[DialogueChoice]) -> void:
	var buttons: Array[Button]
	var branch_index: int = 0
	
	for choice in decisions:
		if choice == null:
			continue

		var new_choice: Button = Button.new()
		var requirement_name: String = ""
		var requirement_type: int = 0

		if choice.dialogue_requirement != null:
			requirement_type = choice.dialogue_requirement.dialogue_requirement_type
		if requirement_type > 0:
			requirement_name = "[Requirement: %s]" % choice.dialogue_requirement.dialogue_requirement_name
		
		new_choice.text = "%s %s" % [choice.dialogue_choice_line, requirement_name]
		new_choice.pressed.connect(try_branch.bind(branch_index))

		buttons.append(new_choice)
		branch_index += 1
	
	send_button_decisions.emit(buttons)

func play_events(events: Array[DialogueEvent]):
	if events.size() <= 0:
		return

	for event in events:
		if event == null:
			continue
		match event.event_type:
			0: # Animation
				event_animation.emit(event.event_delay, event.event_name, false)
			1: # Generic Event
				event_trigger.emit(event.event_delay, event.event_name)
			2: # Item Give
				var item_needed: String = event.event_name.get_slice(":", 0)
				var item_quantity: int = int(event.event_name.get_slice(":", 1))
				event_item.emit(event.event_delay, item_needed, item_quantity, true)
			3: # Item Take
				var item_needed: String = event.event_name.get_slice(":", 0)
				var item_quantity: int = int(event.event_name.get_slice(":", 1))
				event_item.emit(event.event_delay, item_needed, item_quantity, false)
			4: # Quest Give
				event_quest.emit(event.event_delay, event.event_name, true)
			5: # Quest Receive
				event_quest.emit(event.event_delay, event.event_name, false)

## Try to branch out
func try_branch(branch_index: int) -> void:
	var branch_requirement_type: int = current_dialogue_choices[branch_index].dialogue_requirement.dialogue_requirement_type

	match branch_requirement_type:
		0: # None
			play_branch(branch_index)
			return
		1: # Item
			# Check if player has one or more of a particular item, if not then don't play
			var item_needed: String = current_dialogue_choices[branch_index].dialogue_requirement.dialogue_requirement_need.get_slice(":", 0)
			var item_quantity: int = int(current_dialogue_choices[branch_index].dialogue_requirement.dialogue_requirement_need.get_slice(":", 1))
			ask_item.emit(branch_index, item_needed, item_quantity)
			return
		2: # Event
			# Check if player has triggered a certain event, if not then don't play
			ask_event.emit(branch_index, current_dialogue_choices[branch_index].dialogue_requirement.dialogue_requirement_need)
			return
		3: # Quest
			# Check if player has completed a quest, if not then don't play
			ask_quest.emit(branch_index, current_dialogue_choices[branch_index].dialogue_requirement.dialogue_requirement_need)
			return
		_:
			print_debug("Branch requirement type does not exist")
			play_branch(branch_index) # This prevents any softlocks created by mistakes in the code
			return

## Play a branch from the current tree
func play_branch(branch_index: int) -> void:
	play_dialogue_tree(current_dialogue_choices[branch_index].dialogue_tree)
