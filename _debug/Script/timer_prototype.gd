extends Node

signal times_up

@export var time_limit_minutes: int = 5
@onready var time_label = $Time
var time: float
var time_limit: float

func _ready() -> void:
	time_limit = time_limit_minutes * 60

func _physics_process(delta) -> void:
	time += delta
	time_label.text = "%02d:%02d" % [time / 60, int(time) % 60]
	
	if time >= time_limit:
		times_up.emit()
