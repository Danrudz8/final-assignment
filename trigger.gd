extends Area3D

@onready var red_filter = $"../CanvasLayer/ColorRect"
@onready var label = $"../CanvasLayer/Label"

var triggered := false

func _on_body_entered(body):
	if triggered:
		return

	if body.is_in_group("player") and GameState.has_key:
		triggered = true

		red_filter.visible = false
		label.text = "Now dance away x"
		label.visible = true
		
	
	print("entered:", body.name)
