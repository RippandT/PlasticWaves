extends Button

@export var gameplay_test: PackedScene

func _ready():
	button_down.connect(make_game)

func make_game():
	var next_scene = gameplay_test.instantiate()
	get_tree().root.add_child(next_scene)
	get_node("/root/GameplayTest").game_hosted()
	get_tree().root.remove_child(get_node("/root/PrototypeMenu"))
