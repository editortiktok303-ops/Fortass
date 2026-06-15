extends Node2D

var car = null

func _ready():
	car = get_node("Car")

func _process(delta):
	pass

func _on_menu_pressed():
	if car:
		car.save_upgrades()
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
