extends Control


func close_newspaper() -> void:
	call_deferred("queue_free")
