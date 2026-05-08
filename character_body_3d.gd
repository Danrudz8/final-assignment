extends CharacterBody3D

@onready var key = $CSGCombiner3D3

var selected = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var player

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and selected:
		player.pick_up_object(self)

func _ready():
	player = get_tree().get_first_node_in_group("player")
	player.interact_object.connect(_set_selected)
	

	
func _physics_process(delta: float) -> void:
	if player == get_parent(): return
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		

	
func _set_selected(object):
	selected = self == object
	


	
	
