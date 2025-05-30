extends Resource
class_name DialogueBranch

## The dialogue that will play
@export var dialogue_leaves: Array[DialogueLeaf]

## The requirement needed to play this branch
@export var dialogue_requirement: DialogueRequirement

## Set to `true` if the dialogue is branching
@export var is_branching: bool = false

## The choices for a branching dialogue
@export var branching_choices: Array[String]