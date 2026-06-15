extends Node

class_name MatchManager

@export var players_to_start = 2
@export var match_duration = 600  # 10 minutes

var match_active = false
var players_alive = []
var match_time = 0.0
var zone_manager: ZoneManager

func _ready():
	zone_manager = get_tree().root.get_child(0).get_node("WorldManager/ZoneManager")

func _process(delta):
	if match_active:
		match_time += delta
		update_hud()

func start_match():
	if players_alive.size() >= players_to_start:
		match_active = true
		print("Match started! Players: %d" % players_alive.size())

func end_match(winner: Player):
	match_active = false
	print("Match ended! Winner: " + winner.name)

func update_hud():
	# Update HUD with time, players alive, zone status
	pass

func register_player(player: Player):
	players_alive.append(player)

func player_eliminated(player: Player):
	players_alive.erase(player)
	if players_alive.size() == 1:
		end_match(players_alive[0])
