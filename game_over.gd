extends Node2D

func _ready() -> void:
	$TweenedPlayer.play_tweened(load("res://K48 Pyoro Game Over.mp3"), 2)
	pass # Replace with function body.
	


func _on_timer_timeout() -> void:
	SceneManager.goto_scene("res://Start Screen.tscn")
	$TweenedPlayer.stop_tweened(0.3)
	
