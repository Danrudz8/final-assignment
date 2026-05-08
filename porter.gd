extends Area3D

var player_in_range = false
var player = 0

func _on_area_3d_body_entered(body):
	if body.name == "Player":
		player_in_range = true
		player = body
		print("Press E to take keys")

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		player = 0
		
func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		give_keys()
		
func give_keys():
	if player:
		player.has_keys = true
		print("You have the keys! Now go before the studio melts!")


	
