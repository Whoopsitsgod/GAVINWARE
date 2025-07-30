extends Node

var won_game: bool = false

var counter: int = 0

signal game_finished(success: bool)

func transition_speed(speed: int) -> float:
	return 2/(speed*0.01 + 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ship/Button.pressed.connect(_on_pressed)
	$explosion.visible = false
	$Ship.play("default")
	$Macks.play("default")
	print("working")
	pass # Replace with function body.

func start_game(speed: int):
	await get_tree().create_timer(transition_speed(speed)).timeout
	game_finished.emit(won_game)

func _on_pressed():
	counter += 1
	if counter == 10:
		$explosion.visible = true
		$explosion.play("explosion")
		$Ship.play("destroyed")
		$Macks.play("cry")
		won_game = true
