extends Node3D

@onready var red_filter = $CanvasLayer/ColorRect
@onready var label = $CanvasLayer/Label

var intro_done := false


		
func _ready():
	# ONLY check state, do NOT touch UI every frame
	if GameState.has_key:
		print("Now dance away x")
