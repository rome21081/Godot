extends Area2D


var FireballScene = preload("res://Scenes/Fireball.tscn")
onready var spawn_point = $FireballSpawnPoint

onready var timer = $Timer

func _ready():
	
	visible = false
	
	disable_all_attacks()

	timer.wait_time = 4.0
	timer.one_shot = false

func start_battle():
	timer.start()

func stop_battle():
	timer.stop()
	disable_all_attacks()

func _on_Timer_timeout():
	$AnimationPlayer.play("attack")
	yield(get_tree().create_timer(.75), "timeout")
	spawn_fireball()

func disable_all_attacks():
	
	$Attacks/Attack1.monitoring = false
	$Attacks/Attack2.monitoring = false
	$Attacks/Attack3.monitoring = false

func enable_attack1():
	disable_all_attacks()
	$Attacks/Attack1.monitoring = true

func enable_attack2():
	disable_all_attacks()
	$Attacks/Attack2.monitoring = true

func enable_attack3():
	disable_all_attacks()
	$Attacks/Attack3.monitoring = true

func spawn_fireball():
	var fireball = FireballScene.instance()
	get_tree().current_scene.add_child(fireball)

	fireball.global_position = spawn_point.global_position



