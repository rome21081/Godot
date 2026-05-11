extends Node2D


var player_in_range = false


func _ready():
	get_node("Player/Light2D").visible = false 
	yield(Fade.fade_in(1.0), "completed")


var has_talked = false


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		
		player_in_range = true

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		$StaticBody2D/AnimatedSprite.playing = false
		player_in_range = false
		has_talked = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("ui_accept") and not has_talked:
		has_talked = true
		$StaticBody2D/AnimatedSprite.play("default")
		if GameState.aswang_found:
			DialogueManager.start([
				"You found out who it was?",
				"Go out and hunt him down"
			])
			GameState.hasaan
		else:
			DialogueManager.start([
				"You must be Sio, The Babaylan already told me about you.",
				"An Aswang is Wrecking Havoc on this town.",
				"I want you to investigate the towns people.",
				"Also report back to me when you found it"
			])
			GameState.talked_to_captain = true
		


func _on_Exit_body_entered(body):
	yield(Fade.fade_out(1.0), "completed")
	get_tree().change_scene("res://Scenes/Barrio.tscn")
