extends Node2D

var UI : Control
var grid : Node2D
var enemies: Node2D
var player : CharacterBody2D
var startingPosition : Vector2
var enemiesPosition : PackedVector2Array

signal pauseEnemies(isPaused: bool)

func _ready() -> void:
	player = get_node("Player")
	enemies = get_node("Enemies")
	grid = get_node("Grid")
	UI = get_node("UI")
	UI.hide()
	startingPosition = player.position
	enemiesPosition.append(Vector2(1313, 700))
	enemiesPosition.append(Vector2(368, 893))
	var counter : int = 0
	for aChild in enemies.get_children():
		aChild.position = enemiesPosition[counter]
		counter += 1

func _on_player_moving(isMoving: Variant) -> void:
	if isMoving:
		for aChild : Node2D in grid.get_children():
			aChild.get_node("Sprite2D").hide()
		#for aChild : Node2D in enemies.get_children():
			#aChild.get_node("Sprite2D").hide()
		pauseEnemies.emit(true)
	else:
		for aChild : Node2D in grid.get_children():
			aChild.get_node("Sprite2D").show()
		for aChild : Node2D in enemies.get_children():
			aChild.get_node("Sprite2D").show()
		pauseEnemies.emit(false)


func _on_enemy_hit_player() -> void:
	get_tree().paused = true
	UI.show()


func _on_ui_restart_game() -> void:
	print("What happened?")
	player.position = startingPosition
	get_tree().paused = false
	UI.hide()
	var counter : int = 0
	for aChild in enemies.get_children():
		aChild.position = enemiesPosition[counter]
		counter += 1


func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("You win!")
