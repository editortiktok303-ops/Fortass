extends Node3D

class_name WorldManager

@export var world_width = 100
@export var world_height = 64
@export var chunk_size = 16
@export var sea_level = 10

var chunks = {}
var block_data = {}  # Dictionary to store block info at positions
var player: Player

func _ready():
	generate_world()
	spawn_player()

func generate_world():
	print("Generating world...")
	# Generate terrain
	for x in range(-world_width, world_width, chunk_size):
		for z in range(-world_width, world_width, chunk_size):
			generate_chunk(x, z)
	
	print("World generation complete")

func generate_chunk(chunk_x: int, chunk_z: int):
	var chunk = Node3D.new()
	chunk.name = "Chunk_%d_%d" % [chunk_x, chunk_z]
	add_child(chunk)
	
	for x in range(chunk_x, chunk_x + chunk_size):
		for z in range(chunk_z, chunk_z + chunk_size):
			for y in range(sea_level):
				var height = int(sin(x * 0.05) * 5 + cos(z * 0.05) * 5 + sea_level)
				if y < height:
					place_block_silent(Vector3i(x, y, z), "stone" if y > 1 else "dirt")
				elif y == height:
					place_block_silent(Vector3i(x, y, z), "grass")

func place_block(pos: Vector3, block_type: String):
	var grid_pos = pos.round()
	if not block_data.has(grid_pos):
		block_data[grid_pos] = block_type
		visualize_block(grid_pos, block_type)

func place_block_silent(pos: Vector3i, block_type: String):
	block_data[pos] = block_type

func destroy_block(pos: Vector3):
	var grid_pos = pos.round()
	if block_data.has(grid_pos):
		block_data.erase(grid_pos)
		visualize_destruction(grid_pos)

func visualize_block(pos: Vector3i, block_type: String):
	# Create visual representation of block
	var mesh_instance = MeshInstance3D.new()
	var cube = BoxMesh.new()
	cube.size = Vector3.ONE
	mesh_instance.mesh = cube
	mesh_instance.position = pos + Vector3(0.5, 0.5, 0.5)
	
	var material = StandardMaterial3D.new()
	material.albedo_color = get_block_color(block_type)
	mesh_instance.set_surface_override_material(0, material)
	
	var collider = CollisionShape3D.new()
	collider.shape = BoxShape3D.new()
	mesh_instance.add_child(collider)
	
	add_child(mesh_instance)

func visualize_destruction(pos: Vector3i):
	for child in get_children():
		if child is MeshInstance3D and child.position.round() == pos + Vector3(0.5, 0.5, 0.5):
			child.queue_free()

func get_block_color(block_type: String) -> Color:
	match block_type:
		"stone":
			return Color.GRAY
		"dirt":
			return Color(0.6, 0.4, 0.2)
		"grass":
			return Color.GREEN
		"wood":
			return Color(0.5, 0.3, 0.1)
		_:
			return Color.WHITE

func spawn_player():
	player = Player.new()
	add_child(player)
	player.position = Vector3(0, 20, 0)
	player.add_child(CameraController.new())
