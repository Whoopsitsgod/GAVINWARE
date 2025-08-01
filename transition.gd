extends Node2D

signal done_playing()

func start_animation() -> void:
	$AnimationPlayer.play("Laugh")
	$Timer.start()

func _on_timer_timeout() -> void:
	done_playing.emit()
