extends CanvasLayer

@onready var message = $Label
@onready var overlay = $ColorRect

var key_revealed := false


func _ready():
	message.visible = true
	
	await get_tree().create_timer(4.0).timeout
	message.visible = false

func fade_red_overlay():
	var tween = create_tween()
	tween.tween_property(overlay, "modulate:a", 0.0, 3.0)
	
func _process(delta):
	if GameState.has_key and not key_revealed:
		key_revealed = true

		# remove filter
		var tween = create_tween()
		tween.tween_property(overlay, "modulate:a", 0.0, 1.5)

		# show final message
		message.visible = true
		message.text = "Now dance away x"
