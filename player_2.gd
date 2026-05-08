extends CharacterBody3D

signal interact_object

const SPEED = 10
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.03

var gravity = 9.8
var pickedObject

@onready var head  = $Head
@onready var camera = $Head/Camera3D
@onready var hand = $Hand

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	add_to_group("player")
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))
	

	if event.is_action_pressed("interact") and pickedObject:
		pickedObject.reparent(get_tree().current_scene)
		pickedObject = null
		
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0 
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var input_dir = Input.get_vector("left", "right", "up", "down")

	var direction = (transform.basis * Vector3(input_dir.x, 0, -input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0
		
	move_and_slide()
	
		
		

		

		
	

		
	
