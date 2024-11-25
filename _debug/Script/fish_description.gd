extends VBoxContainer

@export var starting_dex: FishdexEntry

@onready var title = $Title
@onready var picture = $Picture
@onready var descriptions = $Descriptions

func _ready() -> void:
	#display_fish_description(starting_dex)
	pass

func display_fish_description(fishdex: FishdexEntry) -> void:
	title.text = fishdex.title
	picture.texture = fishdex.picture
	descriptions.text = fishdex.description

func toggle_visibility() -> void:
	$"../../../..".visible = !$"../../../..".visible

func _unhandled_input(event) -> void:
	if event.is_action_pressed("player_general_openfishdex"):
		toggle_visibility()
