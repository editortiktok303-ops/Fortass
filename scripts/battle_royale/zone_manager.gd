extends Node3D

class_name ZoneManager

@export var initial_zone_radius = 200.0
@export var zone_center = Vector3.ZERO
@export var shrink_interval = 30.0  # Seconds between zone shrinks
@export var shrink_amount = 0.85  # Zone shrinks to 85% each time
@export var damage_per_second = 1.0

var current_radius = initial_zone_radius
var time_until_shrink = shrink_interval
var zone_particles: GPUParticles3D

func _ready():
	create_zone_visual()

func _process(delta):
	time_until_shrink -= delta
	if time_until_shrink <= 0:
		shrink_zone()
		time_until_shrink = shrink_interval

func create_zone_visual():
	zone_particles = GPUParticles3D.new()
	add_child(zone_particles)
	zone_particles.position = zone_center
	# Add particle effect setup

func shrink_zone():
	print("Zone shrinking...")
	var tween = create_tween()
	tween.tween_property(self, "current_radius", current_radius * shrink_amount, 10.0)

func is_in_zone(position: Vector3) -> bool:
	return position.distance_to(zone_center) <= current_radius

func get_safe_position() -> Vector3:
	# Find a random position inside the zone
	var angle = randf() * TAU
	var distance = randf() * current_radius
	return zone_center + Vector3(cos(angle), 0, sin(angle)) * distance
