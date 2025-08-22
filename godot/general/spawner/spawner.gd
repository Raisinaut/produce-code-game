class_name Spawner
extends Node2D

@onready var spawn_line : Path2D = $SpawnLine
@onready var line_position : PathFollow2D = $SpawnLine/LinePosition
@onready var interval : Timer = $Interval

@export var spawn_scene : PackedScene

var rng := RandomNumberGenerator.new()


func _ready() -> void:
	interval.timeout.connect(_on_interval_timeout)
	interval.start()


func _on_interval_timeout():
	# spawn
	pass


func _spawn_scene(scene : PackedScene, at_pos : Vector2, parent : Node2D):
	var inst : Node2D = scene.instantiate()
	inst.global_position = at_pos
	parent.call_deferred("add_child", inst)


func get_random_spawn_position() -> Vector2:
	var r = rng.randf()
	line_position.progress_ratio = r
	return line_position.global_position
