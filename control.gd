extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_start_button_pressed():
	
	get_tree().change_scene_to_file("res://node_2d.tscn")


func _on_credits_button_pressed():
	
	get_tree().change_scene_to_file("res://credit.tscn")
