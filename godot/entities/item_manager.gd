class_name ItemManager
extends Node2D


## Checks each item for a plu match.[br]
## Only removes matches up to the quantity count.[br][br]
## A difference value is returned by the function.[br]
## - Negative values represent excess in items found and not removed.[br]
## - Positive values represent excess in the quantity provided and not found.
func remove_matches(plu : int, quantity : int) -> int:
	if quantity <= 0:
		push_warning("Invalid quantity provided.")
		return 0
	
	var found = 0
	for item : Item in get_children():
		if item.get_plu() == plu:
			if found < quantity:
				item.queue_free()
			found += 1
		else:
			# reengage physics in remaining items
			item.sleeping = false
	
	return quantity - found
