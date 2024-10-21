extends Label

var fish_count: int = 0

func add_to_count(increment: int):
	fish_count += increment
	self.text = str(fish_count)
