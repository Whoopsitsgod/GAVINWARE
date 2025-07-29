extends Control

signal game_finished(success: bool)

var random_words = ["Gas", "Glass", "Bosom", "Wings", "Craigslist", "Apple"]
# Called when the node enters the scene tree for the first time.

var correct_word: String
var incorrect_words: Array[String]
var correct_button_num: int

func _ready() -> void:
	$CenterContainer/GridContainer/Button0.pressed.connect(_on_pressed.bind(0))
	$CenterContainer/GridContainer/Button1.pressed.connect(_on_pressed.bind(1))
	$CenterContainer/GridContainer/Button2.pressed.connect(_on_pressed.bind(2))
	$CenterContainer/GridContainer/Button3.pressed.connect(_on_pressed.bind(3))
	var correct_index = randi() % len(random_words)
	correct_word = random_words[correct_index]
	incorrect_words.clear()
	for i in range(3):
		print("hi")
		while true:
			var incorrect_index = randi() % len(random_words)
			var new_incorrect = random_words[incorrect_index]
			if new_incorrect in incorrect_words:
				continue
			if new_incorrect == correct_word:
				continue
			incorrect_words.append(new_incorrect)
			break
	print(correct_word)
	correct_button_num = randi() % 4
	for i in range(4):
		var button: Button = $CenterContainer/GridContainer.get_children()[i]
		if i == correct_button_num:
			button.text = correct_word
		elif i < correct_button_num:
			button.text = incorrect_words[i]
		elif i > correct_button_num:
			button.text = incorrect_words[i-1]
	
func start_game(speed: int):
	pass

func _on_pressed(button_num: int):
	game_finished.emit(button_num == correct_button_num)
