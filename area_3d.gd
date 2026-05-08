extends Area3D

var time := 0.0
var start_y := 0.0

func _ready():
	start_y = global_position.y

	body_entered.connect(_on_body_entered)

func _process(delta):
	time += delta

	# floating
	global_position.y = start_y + sin(time * 2.0) * 0.2

	# spinning
	rotate_y(delta * 2.0)


func _on_body_entered(body):
	if body.is_in_group("player"):
		GameState.has_key = true
		queue_free()
