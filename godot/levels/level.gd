extends Node2D

@onready var item_manager = %ItemManager
@onready var keypad = %Keypad

func _ready() -> void:
	keypad.submitted.connect(_on_keypad_submitted)

func _on_keypad_submitted(input, quantity):
	item_manager.remove_matches(input, quantity)
