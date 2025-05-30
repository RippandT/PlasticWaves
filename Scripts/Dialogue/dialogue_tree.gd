extends Resource
class_name DialogueTree

## The branch to play
@export var dialogue_tree_branch: DialogueBranch

## The next set of branches
## If none is set, then the dialogue tree will end
@export var next_branches: Array[DialogueTree]