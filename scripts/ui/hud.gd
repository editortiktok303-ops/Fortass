extends CanvasLayer

class_name HUD

@onready var health_label = Label.new()
@onready var ammo_label = Label.new()
@onready var shield_label = Label.new()
@onready var map_mini = Control.new()

var player: Player

func _ready():
	player = get_parent().get_node("Player")
	setup_ui()

func setup_ui():
	# Health
	health_label.text = "HP: 100/100"
	health_label.add_theme_font_size_override("font_sizes/font_size", 24)
	add_child(health_label)
	
	# Ammo
	ammo_label.text = "AMMO: 30"
	ammo_label.position = Vector2(0, 50)
	add_child(ammo_label)
	
	# Shield
	shield_label.text = "SHIELD: 0"
	shield_label.position = Vector2(0, 100)
	add_child(shield_label)

func _process(_delta):
	if player:
		health_label.text = "HP: %.0f/%.0f" % [player.current_health, player.max_health]
		shield_label.text = "SHIELD: %.0f" % player.shield
