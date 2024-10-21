extends CharacterMovement
class_name Fish

@export var visibility_checker: VisibleOnScreenNotifier2D

var flip_fish: bool = false

func _ready() -> void:
	# Stores either -1 or 1 depending on flip_fish
	var flip_int: int = 1 - (2 * int(flip_fish))
	
	visibility_checker.screen_exited.connect(swim_away)
	
	speed_x = speed * (flip_int)
	apply_scale(Vector2(flip_int, 1))

func _physics_process(delta) -> void:
	move_character_topdown(Vector2.RIGHT)

func swim_away() -> void:
	call_deferred("queue_free")
