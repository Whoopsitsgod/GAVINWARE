extends AudioStreamPlayer

func play_tweened(audio_stream: AudioStream, tween_time: float = 1) -> void:
	stream = audio_stream
	volume_linear = 0
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "volume_linear", db_to_linear(0), tween_time)
	play()

func stop_tweened(tween_time: float = 1) -> void:
	volume_linear = db_to_linear(0)
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "volume_linear", 0, tween_time)
	tween.tween_callback(stop)
