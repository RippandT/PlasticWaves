extends Resource
class_name DialogueTree

## The branch to play
@export var dialogue_branch: DialogueBranch

## If `true`, the player will be presented with dialogue choices.
## Make sure that there are choices set in `Dialogue Choices` when set to `true`.
@export var is_branching: bool = false

## The next set of branches.
## If none is set, then the dialogue tree will end when the system asks for the next line.
@export var dialogue_choices: Array[DialogueChoice]