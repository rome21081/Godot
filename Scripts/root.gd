extends StaticBody2D

export(Array, String) var dialogue = [
	"A root blocks this path.",
	"Explore the area.",
	"Something might help."
]

var triggered = false
var player_in_range = false
var has_talked = false


func _process(delta):
	if player_in_range and Input.is_action_just_pressed("ui_accept") and not has_talked:
		has_talked = true
		print("Starting dialogue")
		DialogueManager.start(dialogue)

	if GameState.has_torch and not triggered:
		triggered = true
		$AnimationPlayer.play("root")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player_in_range = true
		print("Player entered")


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		print("Player exited")
