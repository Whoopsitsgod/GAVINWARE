extends Node2D

func _ready() -> void:
	pass # Replace with function body.
	


func _on_timer_timeout() -> void:
	SceneManager.goto_scene("res://Start Screen.tscn")
	
