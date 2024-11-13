extends HBoxContainer
class_name FishInventoryLabel

func display_fish(fish_name: String, fish_weight: float):
	$Name.text = fish_name
	$Weight.text = str(fish_weight) + "KG"
