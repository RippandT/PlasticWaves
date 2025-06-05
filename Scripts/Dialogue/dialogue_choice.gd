extends Resource
class_name DialogueChoice

## The player's line for this branch.
@export_multiline var dialogue_choice_line: String

## The tree of this choice, provided they have the requirement (if there is one).
@export var dialogue_tree: DialogueTree

## The requirement needed to play this branch.
@export var dialogue_requirement: DialogueRequirement