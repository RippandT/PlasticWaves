extends Resource
class_name QuestItem

enum QuestType {
	ITEM,
	TRIGGER
}

@export var quest_type: QuestType = QuestType.ITEM
