extends Node

var item_folder := "res://resources/produce/"
var item_data_list := []


func _ready() -> void:
	populate_item_data_list()


func populate_item_data_list():
	# clear previous list contents
	item_data_list.clear()
	
	# open the directory
	var dir = DirAccess.open(item_folder)
	var list : Array= dir.get_files()
	
	for file_name in list:
		# exclude .import files
		if file_name.ends_with(".import"):
			list.erase(file_name)
			continue
		
		# load and add all other files
		var file_path = item_folder + file_name
		var item_data = load(file_path) as ItemData
		if item_data:
			item_data_list.append(item_data)
		else:
			push_error("Could not load item from ", file_path)


func get_random_item_data():
	var rand_idx = randi() % item_data_list.size()
	return item_data_list[rand_idx]
