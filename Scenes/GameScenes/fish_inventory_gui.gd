extends Control
class_name FishCaughtList

@export var fish_inventory_label: PackedScene
@export var fish_container: VBoxContainer

func display_fish(fish_catched: Array[Dictionary]) -> void:
	for fish in fish_catched:
		var label_instance: FishInventoryLabel = fish_inventory_label.instantiate()
		label_instance.display_fish(fish["fish_name"], fish["fish_weight"])
		fish_container.add_child(label_instance)
