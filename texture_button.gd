extends TextureButton

var items_collected := 0

@export var hover_scale: Vector2 = Vector2(1.1, 1.1)
@export var pressed_scale: Vector2 = Vector2(0.9, 0.9)



func _ready() -> void:
	mouse_entered.connect(_button_enter)
	mouse_exited.connect(_button_exit)
	pressed.connect(_button_pressed)

	await get_tree().process_frame
	pivot_offset = size / 2.0

func _button_enter() -> void:
	create_tween().tween_property(self, "scale", hover_scale, 0.1).set_trans(Tween.TRANS_SINE)
	
	print("hover")
func _button_exit() -> void:
	create_tween().tween_property(self, "scale", Vector2.ONE, 0.1).set_trans(Tween.TRANS_SINE)

func _button_pressed() -> void:
	var button_press_tween: Tween = create_tween()
	button_press_tween.tween_property(self, "scale", pressed_scale, 0.06).set_trans(Tween.TRANS_SINE)
	button_press_tween.tween_property(self, "scale", hover_scale, 0.12).set_trans(Tween.TRANS_SINE)
	button_press_tween.tween_property(self, "modulate:a", 0, 0.25)
	button_press_tween.tween_callback(queue_free)
	
	GameState.items_collected += 1
	queue_free()

	if GameState.items_collected >= 5:
		get_tree().change_scene_to_file("res://black_screen.tscn")
