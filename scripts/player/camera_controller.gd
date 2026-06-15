extends Node3D

class_name CameraController

@export var mouse_sensitivity = 0.003
@export var max_look_angle = 90.0

var camera: Camera3D
var player: CharacterBody3D
var rotation_x = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera = get_parent().camera_3d
	player = get_parent()

func _input(event):
	if event is InputEventMouseMotion:
		handle_mouse_look(event)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED)

func handle_mouse_look(event: InputEventMouseMotion):
	var delta = event.relative
	
	player.rotate_y(-delta.x * mouse_sensitivity)
	rotation_x -= delta.y * mouse_sensitivity
	rotation_x = clamp(rotation_x, -max_look_angle, max_look_angle)
	
	camera.rotation.x = deg_to_rad(rotation_x)
