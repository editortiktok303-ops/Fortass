extends Node

class_name Inventory

@export var max_slots = 40
var slots = {}
var selected_slot = 0

func _init():
	for i in range(max_slots):
		slots[i] = {"item": null, "quantity": 0}

func add_item(item: String, quantity: int = 1) -> bool:
	# Try to stack in existing slot
	for slot in slots.values():
		if slot["item"] == item:
			slot["quantity"] += quantity
			return true
	
	# Find empty slot
	for i in range(max_slots):
		if slots[i]["item"] == null:
			slots[i] = {"item": item, "quantity": quantity}
			return true
	
	return false  # Inventory full

func remove_item(item: String, quantity: int = 1) -> bool:
	for slot in slots.values():
		if slot["item"] == item:
			if slot["quantity"] >= quantity:
				slot["quantity"] -= quantity
				if slot["quantity"] == 0:
					slot["item"] = null
				return true
	
	return false

func get_item_count(item: String) -> int:
	var count = 0
	for slot in slots.values():
		if slot["item"] == item:
			count += slot["quantity"]
	return count

func get_selected_block() -> String:
	var slot = slots[selected_slot]
	if slot["item"] and slot["item"].begins_with("block_"):
		return slot["item"]
	return null

func select_slot(slot_index: int):
	if slot_index >= 0 and slot_index < max_slots:
		selected_slot = slot_index
