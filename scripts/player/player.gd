extends CharacterBody3D

class_name Player

# Movement
@export var move_speed = 7.0
@export var sprint_speed = 12.0
@export var jump_force = 8.0
@export var air_resistance = 0.85
@export var gravity = 9.8

# Combat
@export var max_health = 100.0
@export var current_health: float
@export var shield = 0.0
@export var max_shield = 50.0

# Building
@export var build_range = 10.0
@export var place_delay = 0.2

# References
var camera_3d: Camera3D
var inventory: Inventory
var current_weapon: Weapon
var is_sprinting = false
var can_place_block = true
var input_direction = Vector3.ZERO

func _ready():
	set_up_player()


func set_up_player():
	current_health = max_health
	# Setup camera
	camera_3d = Camera3D.new()
	add_child(camera_3d)
	camera_3d.position.y = 1.6  # Eye height
	
	# Setup inventory
	inventory = Inventory.new()
	
	# Setup collision
	var shape = CapsuleShape3D.new()
	shape.radius = 0.4
	shape.height = 1.8
	$CollisionShape3D.shape = shape


func _physics_process(delta):
	handle_input()
	handle_movement(delta)
	handle_building()
	update_velocity()
	velocity = move_and_slide()


func handle_input():
	input_direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		input_direction.z -= 1
	if Input.is_action_pressed("move_backward"):
		input_direction.z += 1
	if Input.is_action_pressed("move_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("move_right"):
		input_direction.x += 1
	
	input_direction = input_direction.normalized()
	
	# Sprint
	is_sprinting = Input.is_action_pressed("sprint")
	
	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	# Shoot
	if Input.is_action_just_pressed("shoot") and current_weapon:
		current_weapon.fire()


func handle_movement(delta):
	var speed = sprint_speed if is_sprinting else move_speed
	var direction = (transform.basis * input_direction).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x *= air_resistance
		velocity.z *= air_resistance
	
	if not is_on_floor():
		velocity.y -= gravity * delta


func handle_building():
	if not can_place_block:
		return
	
	if Input.is_action_just_pressed("place_block"):
		var block_type = inventory.get_selected_block()
		if block_type:
			place_block(block_type)
			can_place_block = false
			await get_tree().create_timer(place_delay).timeout
			can_place_block = true
	
	if Input.is_action_just_pressed("destroy_block"):
		destroy_block()


func place_block(block_type: String):
	var world = get_tree().root.get_child(0).get_node("WorldManager")
	if world:
		var hit_pos = get_aim_position()
		if hit_pos:
			world.place_block(hit_pos, block_type)


func destroy_block():
	var world = get_tree().root.get_child(0).get_node("WorldManager")
	if world:
		var hit_pos = get_aim_position()
		if hit_pos:
			world.destroy_block(hit_pos)


func get_aim_position() -> Vector3:
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(camera_3d.global_position, camera_3d.global_position + camera_3d.global_transform.basis.z * -build_range)
	var result = space_state.intersect_ray(query)
	
	if result:
		return result.position
	return null

func update_velocity():
	pass  # Velocity handled in handle_movement

func take_damage(damage: float):
	var remaining_damage = damage
	
	if shield > 0:
		shield -= remaining_damage
		if shield < 0:
			remaining_damage = -shield
			shield = 0
		else:
			return
	
	current_health -= remaining_damage
	if current_health <= 0:
		die()

func die():
	print("Player died")
	queue_free()

func add_shield(amount: float):
	shield = min(shield + amount, max_shield)

func heal(amount: float):
	current_health = min(current_health + amount, max_health)
