extends Resource
class_name DialogueLeaf

## Portrait of the character to display.
## Not sure if we need this to be honest
@export var character_portrait: Image

## The name of the character speaking the line
@export var character_name: String

## The dialogue
## Will be localizable in the future
@export_multiline var character_dialogue: String