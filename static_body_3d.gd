extends CharacterBody3D

@onready var key = $CSGCombiner3D3

var selected = false

func _ready():
	get_tree().get_first_node_in_group("player").interact_object.connect(_set_selected)
	
func _set_selected(object):
	selected = self == object
	
		
