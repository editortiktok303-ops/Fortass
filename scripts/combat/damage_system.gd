extends Node

class_name DamageSystem

func apply_damage(target: CharacterBody3D, damage: float, damage_type: String = "generic"):
	if target.has_method("take_damage"):
		match damage_type:
			"headshot":
				target.take_damage(damage * 2.0)  # 2x multiplier
			"explosive":
				target.take_damage(damage * 0.75)
			_:
				target.take_damage(damage)

func create_explosion(position: Vector3, radius: float, damage: float):
	var space_state = get_tree().get_first_physics_3d_space_state()
	if space_state:
		var query = PhysicsShapeQueryParameters3D.new()
		query.shape = SphereShape3D.new()
		query.shape.radius = radius
		query.transform.origin = position
		
		var results = space_state.intersect_shape(query)
		for result in results:
			if result.collider is CharacterBody3D:
				apply_damage(result.collider, damage, "explosive")
