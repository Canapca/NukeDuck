extends CharacterBody2D

var movement = Vector2(0, 0)
var speed_acceleration = 2
var speed_max = 15
var gravity = 120
var jump_force = 2200
var started = false
var score = 0
var alive = true

func _ready() -> void:
	$CanvasLayer/Control2.visible = false

func explode():
	$GPUParticles2D.emitting=true
	$SfxrStreamPlayer/SfxrStreamDeath.play()
	$AnimatedSprite2D.visible = false
	$CanvasLayer/Control.visible = false
	$CanvasLayer/Control2.visible = true
	$CanvasLayer/Control2/Label.text = "YOU DIED\nScore: " + str(score)
	movement.y = 0
	velocity.y = 0
	velocity.x = 0
	gravity = 0
	alive = false

func GetInput():
	if Input.is_action_pressed("Left"):
		movement.x -= speed_acceleration
	if Input.is_action_pressed("Right"):
		movement.x +=  speed_acceleration
	if Input.is_action_pressed("Down"):
		pass
	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y -= jump_force;
		$SfxrStreamPlayer.pitch_scale = randfn(0.8, 0.1)
		$SfxrStreamPlayer.play()
		if !started:
			$Timer.start()
			started = true

func MovePlayer():
	
	# A bunch of speed smoothing operations
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
	if Input.is_action_pressed("Left") and Input.is_action_pressed("Right"):
		movement.x = movement.x / 1.2
	if abs(velocity.x) < 0.1:
		velocity.x = 0
	
	velocity.y += gravity
	move_and_slide()
	if !is_on_floor():
		$AnimatedSprite2D.animation = "Jump"
	elif Input.is_action_pressed("Right") or Input.is_action_pressed("Left"):
		$AnimatedSprite2D.animation = "Run"
		$AnimatedSprite2D.play("Run", 3.0, false)
	else:
		$AnimatedSprite2D.animation = "default"
	if Input.is_action_pressed("Right"):
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("Left"):
		$AnimatedSprite2D.flip_h = false
	velocity.x = movement.x
	move_and_collide(movement)

func _physics_process(_delta: float) -> void:
	GetInput()
	MovePlayer()

# SIGNALS

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $".":
		explode()
		

func _on_timer_timeout() -> void:
	score += 1
	$CanvasLayer/Control/Label.text = "Score: " + str(score)
