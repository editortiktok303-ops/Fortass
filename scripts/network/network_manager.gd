extends Node

class_name NetworkManager

@export var server_port = 9999
@export var max_players = 100

var peer: ENetMultiplayerPeer
var players_connected = {}

func _ready():
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func start_server():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(server_port, max_players)
	if error != OK:
		print("Failed to create server: ", error)
		return
	
	multiplayer.set_multiplayer_peer(peer)
	print("Server started on port ", server_port)

func join_server(host: String, port: int = server_port):
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(host, port)
	if error != OK:
		print("Failed to join server: ", error)
		return
	
	multiplayer.set_multiplayer_peer(peer)
	print("Joining server at ", host, ":", port)

func _on_connected_to_server():
	print("Connected to server")

func _on_server_disconnected():
	print("Disconnected from server")

func _on_peer_connected(peer_id: int):
	print("Peer connected: ", peer_id)
	players_connected[peer_id] = {"ready": false}

func _on_peer_disconnected(peer_id: int):
	print("Peer disconnected: ", peer_id)
	players_connected.erase(peer_id)

func broadcast_player_position(position: Vector3):
	rpc("update_player_position", position)

@rpc
func update_player_position(position: Vector3):
	pass  # Sync player positions across network
