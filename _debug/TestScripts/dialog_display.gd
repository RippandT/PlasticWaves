extends PanelContainer

@export var character_display: Label
@export var dialogue_display: RichTextLabel

func display_dialogue(dialogue: DialogueLeaf):
	character_display.text = dialogue.character_name
	dialogue_display.clear()
	dialogue_display.append_text(dialogue.character_dialogue)
