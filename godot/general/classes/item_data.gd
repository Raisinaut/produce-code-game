class_name ItemData
extends Resource


@export var texture : Texture
@export var theme_color : Color
@export var commodity : String
@export var variety : String
@export var plu : int


func get_full_name():
	var full_name : String = commodity
	# Prepend variety to name
	if variety:
		full_name = full_name.insert(0, str(variety, " "))
	return full_name
