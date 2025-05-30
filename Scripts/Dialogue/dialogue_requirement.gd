extends Resource
class_name DialogueRequirement

## The type of requirement that's neeced
## If set to `None` (default), then there's no requirement
@export_enum("None", "Item", "Event", "Quest") var dialogue_requirement_type: int = 0

## The requirement needed
## If `dialogue_requirement_type` set to `None`, this will be ignored
## If the requirement type is set to `Item` and the player needs more than one of that item, separate the item name and quantity with a `:` (ex. "Stick:5")
@export var dialogue_requirement_need: String