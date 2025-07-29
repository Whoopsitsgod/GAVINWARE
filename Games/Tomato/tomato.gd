extends Node2D

var won_game: bool = false

signal finish_game(success: bool)

func _ready() -> void:
	$Jackson/Button.pressed.connect(_on_pressed)
	$Jackson.play("default")
	$Gavin.play("default")
	
func start_game(speed: int):
	await get_tree().create_timer(speed).timeout
	finish_game.emit(finish_game)

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
