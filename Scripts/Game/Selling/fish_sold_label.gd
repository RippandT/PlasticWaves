extends HBoxContainer
class_name FishSoldLabel

func display_fish(name: String, weight: float, price: float) -> void:
	$Fish.text = name
	$Weight.text = str(weight) + "KG"
	$Price.text = "PHP " + str(price)
