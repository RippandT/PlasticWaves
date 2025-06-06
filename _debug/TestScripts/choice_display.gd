extends PanelContainer

signal close

@export var next_button: Button
@export var choices_container: VBoxContainer
@export var dialogue_system: DialogueSystem

func display_choices(decisions: Array[DialogueChoice]):
	next_button.hide()

	var branch_index = 0
	for choice in decisions:
		print(choice)
		var new_choice: Button = Button.new()
		var requirement_name: String = ""
		var requirement_type: int = 0

		if choice.dialogue_requirement != null:
			requirement_type = choice.dialogue_requirement.dialogue_requirement_type
		if requirement_type > 0:
			requirement_name = "[Requirement: %s]" % choice.dialogue_requirement.dialogue_requirement_name
		
		new_choice.text = "%s %s" % [choice.dialogue_choice_line, requirement_name]
		new_choice.pressed.connect(dialogue_system.try_branch.bind(branch_index))
		new_choice.pressed.connect(reset_choices)
		choices_container.add_child(new_choice)
		
		branch_index += 1

func instantiate_choices(button_decisions: Array[Button]):
	next_button.hide()
	print(button_decisions)
	for button in button_decisions:
		button.pressed.connect(reset_choices)
		choices_container.add_child(button)

func reset_choices():
	next_button.show()

	for choice in choices_container.get_children():
		choice.queue_free()

func dialogue_end():
	next_button.text = "End"
	next_button.pressed.connect(close_dialogue)

func close_dialogue():
	close.emit()