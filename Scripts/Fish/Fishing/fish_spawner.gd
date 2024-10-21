extends Node2D

@export_group("Fish Spawning")
@export var fish: PackedScene
@export var filp_fish: bool = false
@export var spawn_rate: Vector2

@export_group("Spawn Places")
@export var top: Marker2D
@export var bottom: Marker2D

func _ready():
	fish_spawner()
	
## Spawns fishes at an interval
func fish_spawner():
	var y_spawn_pos: float = randf_range(top.position.y, bottom.position.y)
	await get_tree().create_timer(randf_range(spawn_rate.x, spawn_rate.y)).timeout
	spawn_fish(Vector2(top.position.x, y_spawn_pos))
	fish_spawner()

func spawn_fish(location: Vector2):
	var fish_instance := fish.instantiate()
	fish_instance.position = location
	fish_instance.flip_fish = filp_fish
	self.add_child(fish_instance)
