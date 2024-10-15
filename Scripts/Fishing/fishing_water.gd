extends Area2D
class_name FishingWater

func _ready():
	body_entered.connect(help_im_under_the_water)
	body_exited.connect(please_help_me)

func help_im_under_the_water(body: Node2D):
	body.underwater = true

func please_help_me(body: Node2D):
	body.underwater = false
