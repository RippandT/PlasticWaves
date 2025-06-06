extends Resource
class_name DialogueEvent

## The type of event to trigger.
@export_enum("Animation", "Event", "ItemGive", "ItemGet", "QuestGive", "QuestGet") var event_type: int = 0

## The name of the event.
## If the requirement type is set to `ItemGive` or `ItemGet`, and the player needs more than one of that item, separate the item name and quantity with a `:` (ex. "Stick:5")
@export var event_name: String

## The delay before the event is triggered (in seconds)
@export_range(0, 9999.99) var event_delay: float = 0