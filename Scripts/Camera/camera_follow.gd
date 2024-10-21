extends Camera2D

@export var player_to_follow: FishermanMovement
@export var limit_top_left: Marker2D
@export var limit_bottom_right: Marker2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if limit_top_left != null:
		limit_top = limit_top_left.position.y
		limit_left = limit_top_left.position.x
	
	if limit_bottom_right != null:
		limit_bottom = limit_bottom_right.position.y
		limit_right = limit_bottom_right.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_to_follow != null:
		position = player_to_follow.position
