extends Control

signal finish_game(success: bool)


func _ready() -> void:
	$Jackson/Button0.pressed.connect(_on_pressed.bind("hello"))
	
func start_game(speed: int):
	print("tomato has started")

func _on_pressed(button_pressed: String):
	print(button_pressed)
