class_name Spawner
extends Node2D

@export var spawn_scene : PackedScene
@export var autostart_spawn_timer : bool = true
@export_range(0, 10, 0.1, "or_greater") var spawn_interval : float = 1.0
@export_range(0, 10, 1.0, "or_greater") var spawn_quantity : int = 1
@export var instance_parent : Node2D

var rng := RandomNumberGenerator.new()
var spawn_timer : SceneTreeTimer = null


func _ready() -> void:
	if !instance_parent:
		instance_parent = self
	if autostart_spawn_timer:
		start_spawn_timer()


func _on_spawn_timer_timeout() -> void:
	for i in spawn_quantity:
		spawn()
	start_spawn_timer()


func spawn() -> Node2D:
	var inst : Node2D = spawn_scene.instantiate()
	inst.global_position = get_random_spawn_position()
	instance_parent.call_deferred("add_child", inst)
	return inst


func get_random_spawn_position() -> Vector2:
	# perform checks for valid spawn area
	var no_children = get_child_count() == 0
	var invalid_child_type = not (get_child(0) is ReferenceRect)
	# return zero vector if no valid child exists
	if no_children or invalid_child_type:
		push_error("No reference rect provided. Returned zero vector.")
		return Vector2.ZERO
	# generate random coordinates in spawn area
	var spawn_area : ReferenceRect = get_child(0)
	var rand_x = rng.randf_range(0, spawn_area.size.x)
	var rand_y = rng.randf_range(0, spawn_area.size.y)
	# return coordinates relative to the spawn area
	var parent_position = instance_parent.global_position
	return spawn_area.global_position + Vector2(rand_x, rand_y) - parent_position


func start_spawn_timer() -> void:
	spawn_timer = get_tree().create_timer(spawn_interval)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
