extends Node

var won_game: bool = false

var counter: int = 0

signal game_finished(success: bool)

func transition_speed(speed: int) -> float:
	return 2/(speed*0.01 + 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TweenedPlayer.play_tweened(load("res://107-dirty-job-shift-1-2-101soundboards.mp3"), 2)
	$Ship/Button.pressed.connect(_on_pressed)
	$explosion.visible = false
	$Ship.play("default")
	$Macks.play("default")
	print("working")
	pass # Replace with function body.

func start_game(speed: int):
	var time = transition_speed(speed)
	$Timer.start_timer(time)
	$Timer.timeout.connect(func(): game_finished.emit(won_game))
	$Timer.timeout.connect(func(): $TweenedPlayer.stop_tweened(0.3))

func _on_pressed():
	counter += 1
	if counter == 6:
		$explosion.visible = true
		$explosion.play("explosion")
		$Ship.play("destroyed")
		$Macks.play("cry")
		won_game = true
