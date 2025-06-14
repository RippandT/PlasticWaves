extends Area2D
class_name BodyDetection

signal body_detection_state(is_near: bool)

# The name of the node of the specific body to detect. 
# If left blank, it will lookout for all objects within the layer mask provided in Collision
@export var body_name: String = ""

func _ready() -> void:
    var player_detected = func method(body: Node2D, is_near: bool):
        if body_name.is_empty():
            body_detection_state.emit(is_near)
            return
        
        if body.name == body_name:
            body_detection_state.emit(is_near)

    body_entered.connect(player_detected.bind(true))
    body_exited.connect(player_detected.bind(false))