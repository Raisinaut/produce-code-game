class_name Keypad
extends Control

signal submitted(input, quantity)

const MAX_INPUT_LENGTH = 4
const MAX_QUANTITY = 99

@onready var clear_key = %Clear
@onready var quantity_key = %Quantity
@onready var enter_key = %Enter

@onready var input_display = %InputDisplay
@onready var quantity_display = %QuantityDisplay


func _ready() -> void:
	clear_displays()
	connect_signals()


func connect_signals() -> void:
	# function connections
	clear_key.pressed.connect(_on_clear_pressed)
	quantity_key.pressed.connect(_on_quantity_pressed)
	enter_key.pressed.connect(_on_enter_pressed)
	# number connections
	for i : Button in get_tree().get_nodes_in_group("number_keys"):
		var key_value = int(i.name)
		i.pressed.connect(_on_number_pressed.bind(key_value))


func _on_number_pressed(num : int):
	if input_display.text.length() < MAX_INPUT_LENGTH:
		input_display.text += str(num)


func _on_clear_pressed():
	if input_display.text == "":
		quantity_display.text = ""
	else:
		input_display.text = ""
	#clear_displays()


func _on_quantity_pressed():
	var q : int = min(MAX_QUANTITY, get_input_value())
	if q:
		quantity_display.text = "x" + str(q)
	input_display.text = ""


func _on_enter_pressed():
	var i = get_input_value()
	var q = max(1, get_quantity_value())
	submitted.emit(i, q)
	clear_displays()


func clear_displays():
	input_display.text = ""
	quantity_display.text = ""


func get_input_value() -> int:
	return int(input_display.text)

func get_quantity_value() -> int:
	var numbers_only : String = quantity_display.text.substr(1)
	return int(numbers_only)
