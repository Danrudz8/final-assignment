extends Node
var clothing_list : Array

func _ready() -> void:
	clothing_list = get_tree().get_nodes_in_group("clothing")
	
	
func _order_clothing_list() -> void:
	for count in range(clothing_list.size()):
		clothing_list[count].z_index = count
		clothing_list[count].get_child(0).z_index = count
