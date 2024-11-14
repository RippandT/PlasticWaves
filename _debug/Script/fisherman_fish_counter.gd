extends HBoxContainer
class_name FishCounterPrototype

@onready var counter: Label = $Count
var fish_count: int = 0

func _ready():
	await get_tree().create_timer(2.0).timeout
	hide()

func set_visibility(visibility: bool) -> void:
	visible = visibility

func add_to_counter(increment: int) -> void:
	fish_count += increment
	counter.text = str(fish_count)

func clear_counter() -> void:	
	fish_count = 0
	counter.text = str(fish_count)
