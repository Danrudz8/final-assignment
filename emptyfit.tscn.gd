extends Sprite2D
var dragging: bool = false
var of: Vector2 = Vector2.ZERO

@onready var area_2d: Area2D = $Area2D


func _process(_delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() - of


func _on_area_2d_input_event(
	_viewport: Node,
	event: InputEvent,
	_shape_idx: int
) -> void:
	
	if event is InputEventMouseButton:
		
		if event.pressed:
			dragging = true
			
			# store mouse offset
			of = get_global_mouse_position() - global_position
			
		else:
			dragging = false
			
