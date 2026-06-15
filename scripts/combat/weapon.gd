extends Node3D

class_name Weapon

@export var weapon_name = "Rifle"
@export var damage = 25.0
@export var fire_rate = 0.1  # Seconds between shots
@export var ammo_per_shot = 1
@export var ammo_type = "rifle_ammo"
@export var max_ammo = 300
@export var range = 100.0

var ammo = 0
var can_fire = true
var player: Player

func _ready():
	player = get_parent()
	ammo = max_ammo

func fire():
	if not can_fire or ammo <= 0:
		return
	
	can_fire = false
	ammo -= ammo_per_shot
	
	# Raycast for hit detection
	var space_state = get_world_3d().direct_space_state
	var camera = player.camera_3d
	var query = PhysicsRayQueryParameters3D.create(
		camera.global_position,
		camera.global_position + camera.global_transform.basis.z * -range
	)
	
	var result = space_state.intersect_ray(query)
	if result:
		var hit_object = result.collider
		if hit_object is CharacterBody3D and hit_object != player:
			if hit_object.has_method("take_damage"):
				hit_object.take_damage(damage)
	
	print("%s fired! Ammo: %d/%d" % [weapon_name, ammo, max_ammo])
	
	await get_tree().create_timer(fire_rate).timeout
	can_fire = true

func reload(ammo_count: int):
	ammo = min(ammo + ammo_count, max_ammo)

func switch_weapon(new_weapon: Weapon):
	print("Switched to: " + new_weapon.weapon_name)
