extends HBoxContainer
class_name FishCounterPrototype

@onready var counter: Label = $Count
var fish_count: int = 0

func set_visibility(visibility: bool) -> void:
	visible = visibility

func add_to_counter(increment: int) -> void:
	fish_count += increment
	counter.text = str(fish_count)

func clear_counter() -> void:	
	fish_count = 0
	counter.text = str(fish_count)
