# A Day in the Life of Dan - A Game Designer

Name: Daniils Rudzinskis

Student Number:  A00026214

Class Group: TU984

# Video

https://www.youtube.com/watch?v=VCJn6A00Bwg

# Screenshots
Titlescreen Image
<img width="1973" height="1066" alt="Screenshot 2026-05-08 001436" src="https://github.com/user-attachments/assets/7e78d78c-f9db-4047-ae9b-a45529dceb02" />

3D Gameplay Image
<img width="1971" height="1076" alt="Screenshot 2026-05-08 145155" src="https://github.com/user-attachments/assets/4936b694-769e-49e9-9835-34af03c8fd5d" />

2D Gameplay Image
<img width="1981" height="1081" alt="Screenshot 2026-05-08 145136" src="https://github.com/user-attachments/assets/5f0f6be7-6273-4edf-8138-217fd2dec41e" />



# Description of the project
A Game for the Creative Coding 2026 Day In A College Students Life Assignment.
A game that depicts a typical day for me in college. I start off the day with packing my bag. When I am in college and not in a lecture or doing course work, I am dancing with the TU Dublin Dance Society. However, the dance studio is usually very hot. Hence, when you are in the dance studio, you need to collect the window key from the porter to use the dance studio.

# Instructions for use
Download the game from Itch. [Itch](https://dan-rudz.itch.io/day-in-the-life-of-dan-a-gam)
Experience a day in my life!
Left Click to Interact
WASD to move in the 3d scene




Core Loop
- Collect items and pack your bag
- Load into dance studio
- Walk to porter
- Collect the key




# List of classes/assets in the project

| Class/asset | Source | Use |
|-----------|-----------|-----------|
| area_3d.gd | Self written | Makes the key spin, float and disappear once interacted with |
| black_screen.gd | Self written | Transition between two scenes |
| canvas_layer.gd | Self written | Controls UI in 3d scene |
| control.gd | Self written | Buttons in Main Menu |
| credit.gd | Self written | Buttons in Credit Scene |
| GameState | Self written | Acknowledges when player picks up key |
| player_2d.gd | Self written | Player movement |
| text.gd | Self written | Manages text in 3d scene |
| texture_button | Self written | Items to collect |

All art inside game is self made in Adobe Illutarator and Photoshop

# What I am most proud of in the assignment
Transition and 3d scene. I recreated the TU Dublin dance studio accurately using CSGs. The transition gives the game a comedic feel.
# What I learned
How to transition between scenes as well as how to code player movement. 

# Code Examples

## Main Menu 
```GDScript
extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_start_button_pressed():
	
	get_tree().change_scene_to_file("res://node_2d.tscn")


func _on_credits_button_pressed():
	
	get_tree().change_scene_to_file("res://credit.tscn")
```

## 2d Scene Buttons
```GDScript
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
```

## Transition
```GDScript
extends Node2D

func _ready():
	await get_tree().create_timer(2.5).timeout
	get_tree().change_scene_to_file("res://nod_3d.tscn")
```

## UI
```GDScript
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
```

## Text
```GDScript
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
```

## GameState
```GDScript
extends Node

var items_collected := 0

var has_key := false
```

## Credits
```GDScript
extends Control

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://control.tscn")
```

## Player
```GDScript
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
```

## Key
```GDScript
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
```




