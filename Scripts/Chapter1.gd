extends Node2D

var enemy_scene = preload("res://scenes/Enemies.tscn")
var spawn_started = false

func _ready():
	randomize()

func _process(delta):
	if GameState.found_symbol and not spawn_started:
		spawn_started = true
		start_enemy_timer()

func start_enemy_timer():
	var timer = Timer.new()
	timer.wait_time = 5.0
	timer.one_shot = false
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", self, "_on_enemy_timer_timeout")

func _on_enemy_timer_timeout():
	if GameState.talked_to_babaylan:
		return
	
	spawn_enemies()

func spawn_enemies():
	for i in range(2):
		var e = enemy_scene.instance()

		var random_x = rand_range(1600, 2200)
		var random_y = rand_range(100, 600)

		e.position = Vector2(random_x, random_y)
		add_child(e)
