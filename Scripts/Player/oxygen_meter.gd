extends VSlider
class_name OxygenMeter

func setup_meter(max_meter_value: int) -> void:
	value = max_meter_value
	max_value = max_meter_value

func update_meter(meter: int) -> void:
	value = meter
	if value == max_value:
		hide()
	else:
		show()
