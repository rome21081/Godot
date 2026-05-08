extends Node2D

var enemy_scene = preload("res://scenes/Enemies.tscn")
var spawn_started := false
var enemy_timer: Timer

export var spawn_interval := 5.0
export var enemies_per_spawn := 2
export var max_enemies := 8

func _ready():
	randomize()

func _process(delta):
	if GameState.found_symbol and not spawn_started:
		spawn_started = true
		start_enemy_timer()

func start_enemy_timer():
	enemy_timer = Timer.new()
	enemy_timer.wait_time = spawn_interval
	enemy_timer.one_shot = false
	enemy_timer.autostart = true
	add_child(enemy_timer)
	enemy_timer.connect("timeout", self, "_on_enemy_timer_timeout")

func _on_enemy_timer_timeout():
	if GameState.talked_to_babaylan:
		if enemy_timer != null:
			enemy_timer.stop()
		return

	spawn_enemies()

func spawn_enemies():
	var current_enemies = get_tree().get_nodes_in_group("Enemies").size()

	if current_enemies >= max_enemies:
		return

	for i in range(enemies_per_spawn):
		var e = enemy_scene.instance()

		var random_x = rand_range(1600, 2200)
		var random_y = rand_range(100, 600)

		e.global_position = Vector2(random_x, random_y)
		e.add_to_group("Enemies")

		add_child(e)
