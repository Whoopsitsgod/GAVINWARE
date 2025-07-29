extends Control

signal finish_game(success: bool)

var random_words = ["Gas", "Glass", "Bosom", "Wings", "Craigslist", "Apple"]
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	$CenterContainer/GridContainer/Button0.pressed.connect(_on_pressed.bind(0))
	$CenterContainer/GridContainer/Button1.pressed.connect(_on_pressed.bind(1))
	$CenterContainer/GridContainer/Button2.pressed.connect(_on_pressed.bind(2))
	$CenterContainer/GridContainer/Button3.pressed.connect(_on_pressed.bind(3))
	
func start_game(speed: int):
	print("hi")

func _on_pressed(button_num: int):
	print(button_num)
