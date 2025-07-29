extends Node

@onready var transition: Node2D = $TransitionViewport/Transition
@onready var transition_viewport: SubViewport = $TransitionViewport
@onready var mask_viewport: SubViewport = $MaskViewport
@onready var front_mask: SubViewport = $FrontViewport
@onready var root_node: Node = $"TransitionViewport"
@onready var game_viewport: SubViewport = $SubViewportContainer/GameViewport
@onready var display: ColorRect = $Display

@export var inital_health = 4

var health: int
var game_scene: Node

func _ready():
	transition_viewport.world_2d = mask_viewport.world_2d
	front_mask.world_2d = mask_viewport.world_2d
	health = inital_health
	change_game(load("res://Games/FiberOpticCable/FiberOpticCable.tscn"), 1)

func transition_speed(speed: int) -> float:
	return 2/(speed*0.01 + 1)

func change_game(new_game: PackedScene, speed: int) -> void:
	for i: Node in game_viewport.get_children():
		i.queue_free()
	var g = new_game.instantiate()
	game_viewport.add_child(g)
	g.game_finished.connect(on_game_finished)
	var tween = get_tree().create_tween()
	var tween_time = transition_speed(speed)
	tween.set_parallel()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(transition, "scale", Vector2(6.8,6.8), tween_time)
	tween.tween_property(transition, "position", Vector2(320,-120), tween_time)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_method(func(a: float): display.material.set_shader_parameter("Transparency", a), 0.0, 1.0, tween_time)
	tween.tween_callback(func(): display.visible = false).set_delay(tween_time)
	tween.tween_callback(func(): g.start_game(speed)).set_delay(tween_time)

func on_game_finished(success: bool) -> void:
	print('did you win?: ' + str(success))
