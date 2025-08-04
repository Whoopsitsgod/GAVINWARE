extends Control

signal game_finished(success: bool)

var random_words = ["Hyena", "Sauls", "Quesidilla", "Snakes", "Specters", "Idiot Island"]

var videos = [
	["Sauls", "res://Games/FiberOpticCable/sauls.ogv", "res://Games/FiberOpticCable/sauls.ogg", "res://Games/FiberOpticCable/saul.png"],
	["Hyena", "res://Games/FiberOpticCable/hyena.ogv", "res://Games/FiberOpticCable/hyena.ogg", "res://Games/FiberOpticCable/hyena.png"],
	["Snakes", "res://Games/FiberOpticCable/snakes.ogv", "res://Games/FiberOpticCable/snakes.ogg", "res://Games/FiberOpticCable/snakes.png"],
	["Idiot Island", "res://Games/FiberOpticCable/usa.ogv", "res://Games/FiberOpticCable/usa.ogg", "res://Games/FiberOpticCable/idiot_island.png"],
	["Specters", "res://Games/FiberOpticCable/spectre.ogv", "res://Games/FiberOpticCable/spectre.ogg", "res://Games/FiberOpticCable/specter.png"],
	["Quesidilla", "res://Games/FiberOpticCable/que.ogv", "res://Games/FiberOpticCable/que.ogg", "res://Games/FiberOpticCable/quesadilla.png"]
]


var correct_word: String
var incorrect_words: Array[String]
var correct_button_num: int
var speed: int

func _ready() -> void:
	$CenterContainer/GridContainer/Button0.pressed.connect(_on_pressed.bind(0))
	$CenterContainer/GridContainer/Button1.pressed.connect(_on_pressed.bind(1))
	$CenterContainer/GridContainer/Button2.pressed.connect(_on_pressed.bind(2))
	$CenterContainer/GridContainer/Button3.pressed.connect(_on_pressed.bind(3))
	var correct_index = randi() % len(videos)
	var video = videos[correct_index]
	$VideoStreamPlayer.stream = load(video[1])
	$Image.material.set_shader_parameter("Texture", load(video[3]))
	$AudioStreamPlayer.stream = load(video[2])
	correct_word = video[0]
	incorrect_words.clear()
	$TweenedPlayer.play_tweened(load("res://01 Metallic Monks.mp3"), 2)
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
	$VideoStreamPlayer.play()
	$VideoStreamPlayer.paused = true
	
func start_game(p_speed: int):
	speed = p_speed
	$VideoStreamPlayer.paused = false

func transition_speed() -> float:
	return 2/(speed*0.01 + 1)

func _on_pressed(button_num: int):
	$Image.visible = true
	var tween = get_tree().create_tween()
	var tween_time = transition_speed()
	$Timer.stop_timer()
	tween.set_parallel()
	tween.tween_method(func(a): $Image.material.set_shader_parameter("Transparency", a), 0.0, 1.0, tween_time)
	tween.tween_callback(func(): $AudioStreamPlayer.play()).set_delay(tween_time/2)
	tween.set_parallel(false)
	tween.tween_callback($TweenedPlayer.stop_tweened.bind(0.3))
	tween.tween_callback(func(): game_finished.emit(button_num == correct_button_num))

func _on_video_stream_player_finished() -> void:
	$VideoStreamPlayer.visible = false
	$Timer.start_timer(transition_speed())
	$Timer.timeout.connect(func(): _on_pressed(-1))
