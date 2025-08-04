extends Node

signal game_finished(success: bool)

var won_game: bool = false

var counter: int = 0

func transition_speed(speed: int) -> float:
	return 2/(speed*0.01 + 1)

func _ready() -> void:
	$NextbotSaul/Button.pressed.connect(_on_pressed.bind($NextbotSaul/Button))
	$NextbotSaul2/Button.pressed.connect(_on_pressed.bind($NextbotSaul2/Button))
	$NextbotSaul3/Button.pressed.connect(_on_pressed.bind($NextbotSaul3/Button))
	$NextbotSaul4/Button.pressed.connect(_on_pressed.bind($NextbotSaul4/Button))
	$TweenedPlayer.play_tweened(load("res://H05 Crygor's Bathroom Jam 01.mp3"), 2)
	
func start_game(speed: int):
	var time = transition_speed(speed)
	$Timer.start_timer(time)
	$Timer.timeout.connect(func(): game_finished.emit(won_game))
	$Timer.timeout.connect(func(): $TweenedPlayer.stop_tweened(0.3))

func _on_pressed(button: Node):
	button.get_parent().visible = false
	button.disabled = true
	counter += 1
	$AudioStreamPlayer.play()
	_check_win()
	pass
	
func _check_win():
	if counter == 4:
		$Timer.stop_timer()
		won_game = true
		game_finished.emit(won_game)
		$TweenedPlayer.stop_tweened(0.3)
