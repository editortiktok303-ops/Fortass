extends CharacterBody2D

# Physics
var max_speed = 500
var acceleration = 800
var friction = 600
var rotation_speed = 5

# Nitro
var nitro_max = 100
var nitro_current = 100
var nitro_consume_rate = 30
var nitro_recharge_rate = 15
var nitro_speed_boost = 400
var is_nitro_active = false

# Drifting
var is_drifting = false
var drift_threshold = 0.7
var drift_money_multiplier = 1.0
var drift_timer = 0

# Money
var money = 0
var money_earned_this_session = 0

# Upgrades
var speed_level = 1
var acceleration_level = 1
var nitro_level = 1

# References
var game_scene = null

func _ready():
	game_scene = get_parent()
	load_upgrades()
	nitro_current = nitro_max

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	
	# Rotation
	if input_vector.x != 0:
		rotation += input_vector.x * rotation_speed * delta
	
	# Calculate forward direction
	var forward = Vector2(sin(rotation), -cos(rotation))
	
	# Acceleration
	var current_max_speed = max_speed
	if is_nitro_active and nitro_current > 0:
		current_max_speed += nitro_speed_boost
		nitro_current = max(0, nitro_current - nitro_consume_rate * delta)
		drift_money_multiplier = 1.5
	else:
		is_nitro_active = false
		nitro_current = min(nitro_max, nitro_current + nitro_recharge_rate * delta)
		if not is_drifting:
			drift_money_multiplier = 1.0
	
	# Check for drifting
	var current_speed = velocity.length()
	if input_vector.x != 0 and current_speed > max_speed * 0.5:
		is_drifting = true
		drift_timer += delta
	else:
		if is_drifting:
			var drift_bonus = int(drift_timer * 100)
			money += drift_bonus
			money_earned_this_session += drift_bonus
		is_drifting = false
		drift_timer = 0
		drift_money_multiplier = 1.0
	
	# Movement
	if input_vector.y > 0:
		velocity = velocity.move_toward(forward * current_max_speed, acceleration * input_vector.y * delta)
	elif input_vector.y < 0:
		velocity = velocity.move_toward(-forward * (max_speed * 0.5), acceleration * abs(input_vector.y) * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	# Earn money while driving
	money += int(current_speed * delta * 0.05)
	money_earned_this_session += int(current_speed * delta * 0.05)
	
	move_and_slide()
	
	# Wrap around screen
	var screen_size = get_viewport_rect().size
	if position.x < -100:
		position.x = screen_size.x + 100
	elif position.x > screen_size.x + 100:
		position.x = -100
	if position.y < -100:
		position.y = screen_size.y + 100
	elif position.y > screen_size.y + 100:
		position.y = -100

func _process(delta):
	# Nitro input
	if Input.is_action_just_pressed("ui_space"):
		if nitro_current > 0:
			is_nitro_active = true
	
	# Update UI
	update_ui()

func update_ui():
	if game_scene and game_scene.has_node("UI/HBoxContainer/MoneyLabel"):
		game_scene.get_node("UI/HBoxContainer/MoneyLabel").text = "Money: $%d" % money
	
	if game_scene and game_scene.has_node("UI/HBoxContainer/SpeedLabel"):
		var speed_kmh = velocity.length() * 0.2
		game_scene.get_node("UI/HBoxContainer/SpeedLabel").text = "Speed: %.0f km/h" % speed_kmh
	
	if game_scene and game_scene.has_node("UI/HBoxContainer/NitroLabel"):
		game_scene.get_node("UI/HBoxContainer/NitroLabel").text = "Nitro: %.0f%%" % (nitro_current / nitro_max * 100)
	
	if game_scene and game_scene.has_node("UI/NitroBar"):
		game_scene.get_node("UI/NitroBar").value = nitro_current / nitro_max * 100

func apply_upgrades():
	max_speed = 500 + (speed_level - 1) * 100
	acceleration = 800 + (acceleration_level - 1) * 200
	nitro_max = 100 + (nitro_level - 1) * 50

func save_upgrades():
	var data = {
		"money": money,
		"speed_level": speed_level,
		"acceleration_level": acceleration_level,
		"nitro_level": nitro_level
	}
	var config = ConfigFile.new()
	config.set_value("car", "money", data["money"])
	config.set_value("car", "speed_level", data["speed_level"])
	config.set_value("car", "acceleration_level", data["acceleration_level"])
	config.set_value("car", "nitro_level", data["nitro_level"])
	config.save("user://car_data.cfg")

func load_upgrades():
	var config = ConfigFile.new()
	if config.load("user://car_data.cfg") == OK:
		money = config.get_value("car", "money", 0)
		speed_level = config.get_value("car", "speed_level", 1)
		acceleration_level = config.get_value("car", "acceleration_level", 1)
		nitro_level = config.get_value("car", "nitro_level", 1)
	
	apply_upgrades()
