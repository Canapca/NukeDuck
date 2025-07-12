extends CharacterBody2D

var movement = Vector2(0, 0)
var speed_acceleration = 2
var speed_max = 15
var gravity = 100
var jump_force = 2000

func GetInput():
	if Input.is_action_pressed("Left"):
		movement.x -= speed_acceleration
	if Input.is_action_pressed("Right"):
		movement.x +=  speed_acceleration
	if Input.is_action_pressed("Down"):
		pass
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y -= jump_force;

func MovePlayer():
	move_and_collide(movement)
	if (movement.x > speed_max):
		movement.x = speed_max
	elif (movement.x < -speed_max):
		movement.x = -speed_max
	if (! Input.is_action_pressed("Left")) and (! Input.is_action_pressed("Right")):
		movement.x = movement.x / 1.2
	if abs(movement.x) < 0.1:
		movement.x = 0
	if (! Input.is_action_pressed("Left")) or (! Input.is_action_pressed("Right")):
		velocity.x = velocity.x / 1.2
	if abs(velocity.x) < 0.1:
		velocity.x = 0
	velocity.y += gravity
	move_and_slide()
	

func _physics_process(delta: float) -> void:
	GetInput()
	MovePlayer()
