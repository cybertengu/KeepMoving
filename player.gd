extends CharacterBody2D

@export var speed : int = 400 # How fast the player will move (pixels/sec).
var screen_size : Vector2 # Size of the game window.
signal moving(isMoving)

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	var is_moving : bool = false
	velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		is_moving = true
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		is_moving = true
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		is_moving = true
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		is_moving = true
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	move_and_collide(velocity * delta)
	moving.emit(is_moving)
