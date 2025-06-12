extends Node
class_name QuestChecker

signal quest_new(quest: QuestItem)
signal quest_complete(quest: QuestItem)
signal send_quest(quest: QuestItem)

func request_quest_status() -> void:
    pass