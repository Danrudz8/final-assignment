extends Control

@onready var label = $Label

var full_text := "Great, time to go dance with the Dance Society
 at Lower House!! Wait..."
var speed := 0.03

func _ready():
	label.text = "Great, time to go dance with the Dance Society
 at Lower House!! Wait..."
	label.modulate.a = 0

	var fade = create_tween()
	fade.tween_property(label, "modulate:a", 1.0, 1.0)

	await type_text()
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://nod_3d.tscn")


func type_text():
	for i in full_text.length():
		label.text = full_text.substr(0, i + 1)
		await get_tree().create_timer(speed).timeout
