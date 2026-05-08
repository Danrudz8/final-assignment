extends CanvasLayer

@onready var rect = $ColorRect

func _ready():
	rect.modulate.a = 0.0
	
func fade_in(time := 1.0):
	rect.modulate.a = 0
	var t = create_tween()
	t.tween_property(rect, "modulate:a", 1.0, time)
	await t.finished

func fade_out(time := 1.0):
	rect.modulate.a = 1
	var t = create_tween()
	t.tween_property(rect, "modulate:a", 0.0, time)
	await t.finished
	
