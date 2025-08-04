extends Node2D

var won_game: bool = false

signal game_finished(success: bool)

func transition_speed(speed: int) -> float:
	return 2/(speed*0.01 + 1)

func _ready() -> void:
	$Jackson/Button.pressed.connect(_on_pressed)
	$Jackson.play("default")
	$Gavin.play("default")
	$TweenedPlayer.play_tweened(load("res://140-race-calibration-101soundboards.mp3"), 2)
	
func start_game(speed: int):
	var time = transition_speed(speed)
	$Timer.start_timer(time)
	$Timer.timeout.connect(func(): game_finished.emit(won_game))
	$Timer.timeout.connect(func(): $TweenedPlayer.stop_tweened(0.3))

func _on_pressed():
	$Gavin.play("get_ready")
	await get_tree().create_timer(0.5).timeout
	$Gavin.play("hit")
	$Jackson.play("struck")
	var tween = create_tween()
	tween.tween_property($Jackson, "position", Vector2(1200,240), 1.5)
	tween.set_parallel()
	tween.tween_property($Jackson, "rotation", 2, 1.5)
	won_game = true
