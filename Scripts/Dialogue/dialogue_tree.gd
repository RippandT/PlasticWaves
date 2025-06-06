extends Resource
class_name DialogueTree

var dialog_choice: Dictionary = {
    ## The player's line for this branch.
    "dialogue_choice_line": "",

    ## The tree of this choice, provided they have the requirement (if there is one).
    "dialogue_tree": DialogueTree,

    ## The requirement needed to play this branch.
    "dialogue_requirement": DialogueRequirement
}
## The branch to play
@export var dialogue_branch: DialogueBranch

## If `true`, the player will be presented with dialogue choices.
## If `false`, then the dialogue tree will end when the system asks for the next line.
@export var is_branching: bool = false

## The next set of branches.
## If none is set and `is_branching` is `true`, it will loop back to the previous choices.
@export var dialogue_choices: Array[DialogueChoice]