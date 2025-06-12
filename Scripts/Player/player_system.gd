extends Node
class_name PlayerSystem

var player_data: PlayerData

func quest_complete(quest: QuestItem):
    for current_quest in player_data.player_quest:
        if quest.quest_id == current_quest.quest_id:
            current_quest.is_quest_completed = true
    
func quest_post_new(quest: QuestItem):
    player_data.player_quest.append(quest)

func quest_check_status(quest: QuestItem) -> bool:
    for current_quest in player_data.player_quest:
        if quest.quest_id == current_quest.quest_id:
            return current_quest.is_quest_completed
    
    print("Quest does not exist in player data yet. Might need to look for the trigger for that quest.")
    return false

func save_game() -> void:
    pass

func load_game() -> void:
    pass