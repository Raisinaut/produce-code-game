class_name Item
extends RigidBody2D

@export var data : ItemData

@onready var sprite := $Sprite2D
@onready var background := $Background
@onready var onscreen_notifier := $VisibleOnScreenNotifier2D


func _ready() -> void:
	data = DataManager.get_random_item_data()
	sync_node_properties()
	onscreen_notifier.screen_exited.connect(_on_screen_exited)


func _process(_delta: float) -> void:
	sprite.global_rotation = 0


func sync_node_properties():
	sprite.texture = data.texture
	background.modulate = data.theme_color


func get_plu() -> int:
	return data.plu


func _on_screen_exited():
	queue_free()
