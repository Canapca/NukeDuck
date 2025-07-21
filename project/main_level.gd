extends Node2D

# TESTING ONLY VARIABLES
var floor_repeats = 10 # Amount of floors to create
var current_position_height = 0 # Very shitty approach to knowing where to place the next floor
var floor_object = preload("res://Objects/Floors/floor_test_1.tscn")

func place_floors():
	var current_child = null
	for loop in range(floor_repeats):
		current_child = floor_object.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
		add_child(current_child)
		current_position_height -= 1088
		current_child.position.y = current_position_height

func _ready() -> void:
	place_floors()
