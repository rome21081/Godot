extends Node2D

var enemy_scene = preload("res://scenes/Enemies.tscn")
var spawn_started := false
var enemy_timer: Timer

export var spawn_interval := 5.0
export var enemies_per_spawn := 2
export var max_enemies := 8

func _ready():
	
	yield(get_tree(), "idle_frame")

	if GameState.has_return_position:

		var player = get_tree().get_nodes_in_group("Player")[0]

		player.global_position = GameState.return_position + Vector2(0, 40)

		GameState.has_return_position = false
	
	Life.set_enabled(true)
	yield(Fade.fade_in(1.0), "completed")
	
	if GameState.chapter ==6:
		GameState.hasaan = true
		DialogueManager.start([
			"you are back where you started from",
			"The Dwende's are still infesting the town",
			"Go to the forest and enter the cave"
		])
		spawn_enemies()
	else:
		DialogueManager.start([
			"Chapter I: The Night the Town Changed",
			"Talk to the Old Man for clues"
		])
	
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

	var bounds = get_tree().get_current_scene().get_node("CameraBounds")

	var min_x = bounds.rect_global_position.x
	var min_y = bounds.rect_global_position.y
	var max_x = min_x + bounds.rect_size.x
	var max_y = min_y + bounds.rect_size.y

	for i in range(enemies_per_spawn):

		var e = enemy_scene.instance()

		var random_x = rand_range(min_x, max_x)
		var random_y = rand_range(min_y, max_y)

		e.global_position = Vector2(random_x, random_y)
		e.add_to_group("Enemies")

		add_child(e)
