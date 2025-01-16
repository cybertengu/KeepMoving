extends RigidBody2D

signal hit_player
var sprite : Sprite2D
var target : CharacterBody2D
var paused : bool
@export var SPEED : int

func _ready() -> void:
	paused = false
	sprite = get_node("Sprite2D")
	target = get_tree().get_first_node_in_group("player")

func seek(delta) -> void:
	var velocity = target.position - position
	velocity = velocity.normalized()
	velocity *= SPEED * delta
	move_and_collide(velocity)

func _process(delta: float) -> void:
	if not paused:
		seek(delta)
	else:
		print("I should be paused")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#print("Hello player, you will die!")
		hit_player.emit()
		sprite.show()


func _on_level_pause_enemies(isPaused: bool) -> void:
	print("Did I pause?", isPaused)
	paused = isPaused
