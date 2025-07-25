extends Node2D

# TESTING ONLY VARIABLES
var floor_repeats = 512 # Amount of floors to create
var current_position_height = 0 # Very shitty approach to knowing where to place the next floor
var floor_count = 6 # The amount of prepared floor_test objects we can pick random values from
var floor_object = Object
var raise_speed = 1

func place_floors():
	var current_child = null
	for loop in range(floor_repeats):
		floor_object = load("res://Objects/Floors/floor_test_"+ str(((randi() % floor_count) + 1)) +".tscn")
		current_child = floor_object.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		add_child(current_child)
		current_position_height -= 1088
		current_child.position.y = current_position_height
		# PLACE BACKGROUND
		floor_object = load("res://Objects/Background/Background.tscn")
		current_child = floor_object.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		add_child(current_child)
		current_child.position.y = current_position_height
		

func raiseBar():
	$WallOfFire.position.y -= raise_speed
	if $"Player Character".position.y < $WallOfFire.position.y - 100:
		$WallOfFire.position.y -= 100

func _ready() -> void:
	randomize()
	place_floors()

func _process(delta: float) -> void:
	if $"Player Character".alive:
		raiseBar()
