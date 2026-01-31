extends Button

enum GROUPS {
	NUMBERS,
	FUNCTIONS
}

@export var group : GROUPS

func _ready() -> void:
	match group:
		GROUPS.NUMBERS:
			add_to_group("number_keys")
			set_shortcut_to_num_key(int(text))
		GROUPS.FUNCTIONS:
			add_to_group("function_keys")

func set_shortcut_to_num_key(value : int) -> void:
	shortcut = Shortcut.new()
	var key_event = InputEventKey.new()
	var keycode = KEY_0 + value
	key_event.keycode = keycode
	shortcut.events = [key_event]
