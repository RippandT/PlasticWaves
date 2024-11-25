extends Control

func _ready() -> void:
	show()

func close_newspaper() -> void:
	call_deferred("queue_free")
