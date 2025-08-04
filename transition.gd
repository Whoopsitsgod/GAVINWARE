extends Node2D

signal done_playing()

func start_animation() -> void:
	$AnimationPlayer.play("Laugh")
	$Timer.start()

func _on_timer_timeout() -> void:
	done_playing.emit()

func set_health(health: int):
	$Health1.visible = health >= 4
	$Health2.visible = health >= 3
	$Health3.visible = health >= 2
	$Health4.visible = health >= 1
	
