extends Area2D
class_name FishingWater

func _ready():
	body_entered.connect(help_im_under_the_water)
	body_exited.connect(please_help_me)

# Both functions can only detect the player thru the layer mask

## Sets the player to swim
func help_im_under_the_water(body: Node2D) -> void:
	body.underwater = true

## Sets the player to not swim
func please_help_me(body: Node2D) -> void:
	body.underwater = false
