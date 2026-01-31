class_name Item
extends RigidBody2D

@export var data : ItemData

@onready var sprite := $Sprite2D
@onready var background := $Background
@onready var onscreen_notifier := $VisibleOnScreenNotifier2D
@onready var mouse_detection := $MouseDetection
@onready var name_label := $NameLabel

var displaying_name : bool = false : set = set_displaying_name


func _ready() -> void:
	data = DataManager.get_random_item_data()
	sync_node_properties()
	
	name_label.top_level = true
	name_label.hide()
	
	onscreen_notifier.screen_exited.connect(_on_screen_exited)
	# mouse detection signals
	mouse_detection.mouse_entered.connect(set_displaying_name.bind(true))
	mouse_detection.mouse_exited.connect(set_displaying_name.bind(false))


func _process(_delta: float) -> void:
	sprite.global_rotation = 0
	# update label position
	var label_center_offset = name_label.size * 0.5
	name_label.global_position = global_position - label_center_offset


func sync_node_properties():
	sprite.texture = data.texture
	background.modulate = data.theme_color
	name_label.text = data.get_full_name()


func get_plu() -> int:
	return data.plu


func _on_screen_exited():
	queue_free()


func set_displaying_name(state):
	displaying_name = state
	# show name
	name_label.visible = state
	# darken visuals to show text
	var darkening = int(state) * 0.5
	sprite.modulate = Color.WHITE.darkened(darkening)
	background.modulate = data.theme_color.darkened(darkening)
