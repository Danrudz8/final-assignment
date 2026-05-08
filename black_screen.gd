extends Node2D

func _ready():
	await get_tree().create_timer(2.5).timeout
	get_tree().change_scene_to_file("res://nod_3d.tscn")
