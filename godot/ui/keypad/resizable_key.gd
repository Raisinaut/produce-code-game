@tool
extends Button

@export_range(1, 3, 1) var h_slots : int = 1 : set = set_h_slots
@export_range(1, 3, 1) var v_slots : int = 1 : set = set_v_slots
@export_range(0, 200, 1) var slot_size : int = 150 : set = set_slot_size


func set_h_slots(value):
	h_slots = value
	update_button_minimums()

func set_v_slots(value):
	v_slots = value
	update_button_minimums()

func set_slot_size(value):
	slot_size = value
	update_button_minimums()


func update_button_minimums():
	custom_minimum_size.x = h_slots * slot_size
	custom_minimum_size.y = v_slots * slot_size
