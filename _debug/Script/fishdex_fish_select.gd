extends Button

signal change_dex(fishdex: FishdexEntry)

@export var fishdex: FishdexEntry

func _ready() -> void:
	button_down.connect(func(): change_dex.emit(fishdex))
