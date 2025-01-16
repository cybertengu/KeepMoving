extends Control

signal restart_game


func _on_button_pressed() -> void:
	restart_game.emit()
