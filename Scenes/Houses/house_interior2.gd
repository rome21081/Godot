extends Node2D


func _ready():
	get_node("Player/Light2D").visible = false 
	yield(Fade.fade_in(1.0), "completed")
	GameState.hasaan=true
	
	DialogueManager.start([
		"Who are you, why did you enter our house"
	])

func _on_Exit_body_entered(body):
	yield(Fade.fade_out(1.0), "completed")
	get_tree().change_scene("res://Scenes/Barrio.tscn")


func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return

	DialogueManager.start([
		"Sio: Don't worry maam I'm here to protect you and your child",
		"Mother: What do you mean?",
		"Sio: A Aswang is coming here"
	])

	yield(DialogueManager, "dialogue_finished")

	spawn_enemies()

func spawn_enemies():
	var enemy_scene = preload("res://scenes/Aswang.tscn")

	for i in range(1):
		var e = enemy_scene.instance()
		e.position = Vector2(2, 249)
		add_child(e)
