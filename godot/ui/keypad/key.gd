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
		GROUPS.FUNCTIONS:
			add_to_group("function_keys")
