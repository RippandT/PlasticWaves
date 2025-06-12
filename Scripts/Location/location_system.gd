extends Node2D
class_name LocationSystem

@export var location_bundle: LocationBundle
@export_dir var location_scene_location: String

var current_location: LocationData

func load_location_bundle() -> void:
    pass