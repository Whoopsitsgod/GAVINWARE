extends AnimatedSprite2D

signal timeout()

var steps_taken = 0
var emitted = false

func start_timer(time: float) -> void:
	var step = time/8
	$Timer.wait_time = step
	$Timer.start()

func stop_timer():
	emitted = true

func _on_timer_timeout() -> void:
	if emitted:
		return
	if steps_taken >= 8:
		timeout.emit()
		emitted = true
		return
	if steps_taken == 7:
		self.visible = false

	steps_taken += 1
	frame += 1
