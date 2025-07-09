extends CharacterBody2D

var movement = Vector2(0, 0)
var speed_acceleration = 2
var speed_max = 15

func GetInput():
	if Input.is_action_pressed("Left"):
		movement.x -= speed_acceleration
	if Input.is_action_pressed("Right"):
		movement.x +=  speed_acceleration
	if Input.is_action_pressed("Down"):
		pass
	if Input.is_action_pressed("Up"):
		pass

func MovePlayer():
	move_and_collide(movement)
	if (movement.x > speed_max):
		movement.x = speed_max
	elif (movement.x < -speed_max):
		movement.x = -speed_max
	if (! Input.is_action_pressed("Left")) and (! Input.is_action_pressed("Right")):
		movement.x = movement.x / 1.6
	if abs(movement.x) < 0.1:
		movement.x = 0
	

func _physics_process(delta: float) -> void:
	GetInput()
	MovePlayer()
