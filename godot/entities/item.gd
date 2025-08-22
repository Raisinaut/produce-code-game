extends RigidBody2D

@export var data : ItemData

@onready var sprite := $Sprite2D
@onready var background := $Background


func _ready() -> void:
	data = DataManager.get_random_item_data()
	sync_node_properties()



func _process(_delta: float) -> void:
	sprite.global_rotation = 0


func sync_node_properties():
	sprite.texture = data.texture
	background.modulate = data.theme_color
