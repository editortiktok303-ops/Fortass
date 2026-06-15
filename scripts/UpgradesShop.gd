extends Control

var money = 0
var speed_level = 1
var acceleration_level = 1
var nitro_level = 1

var speed_cost = 500
var acceleration_cost = 300
var nitro_cost = 400

func _ready():
	load_data()
	update_ui()

func load_data():
	var config = ConfigFile.new()
	if config.load("user://car_data.cfg") == OK:
		money = config.get_value("car", "money", 0)
		speed_level = config.get_value("car", "speed_level", 1)
		acceleration_level = config.get_value("car", "acceleration_level", 1)
		nitro_level = config.get_value("car", "nitro_level", 1)

func save_data():
	var config = ConfigFile.new()
	config.set_value("car", "money", money)
	config.set_value("car", "speed_level", speed_level)
	config.set_value("car", "acceleration_level", acceleration_level)
	config.set_value("car", "nitro_level", nitro_level)
	config.save("user://car_data.cfg")

func update_ui():
	get_node("VBoxContainer/MoneyLabel").text = "Money: $%d" % money
	
	var speed_label = get_node("VBoxContainer/ScrollContainer/VBoxContainer2/Speed/MarginContainer/HBoxContainer/CostLabel")
	speed_label.text = "Level %d - Cost: $%d" % [speed_level, speed_cost]
	
	var accel_label = get_node("VBoxContainer/ScrollContainer/VBoxContainer2/Acceleration/MarginContainer/HBoxContainer/CostLabel")
	accel_label.text = "Level %d - Cost: $%d" % [acceleration_level, acceleration_cost]
	
	var nitro_label = get_node("VBoxContainer/ScrollContainer/VBoxContainer2/Nitro/MarginContainer/HBoxContainer/CostLabel")
	nitro_label.text = "Level %d - Cost: $%d" % [nitro_level, nitro_cost]

func _on_speed_upgrade_pressed():
	if money >= speed_cost:
		money -= speed_cost
		speed_level += 1
		speed_cost = int(speed_cost * 1.5)
		up date_ui()
		save_data()

func _on_acceleration_upgrade_pressed():
	if money >= acceleration_cost:
		money -= acceleration_cost
		acceleration_level += 1
		acceleration_cost = int(acceleration_cost * 1.5)
		update_ui()
		save_data()

func _on_nitro_upgrade_pressed():
	if money >= nitro_cost:
		money -= nitro_cost
		nitro_level += 1
		nitro_cost = int(nitro_cost * 1.5)
		update_ui()
		save_data()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
