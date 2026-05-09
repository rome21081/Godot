extends Area2D

var player_in_range = false
var triggered = false

func _on_FakeBaby_body_entered(body):
	if body.name == "Player":
		player_in_range = true
		body.set_light(false)

func _on_FakeBaby_body_exited(body):
	if body.name == "Player":
		player_in_range = false


func _process(delta):

	if player_in_range \
	and Input.is_action_just_pressed("ui_accept") \
	and not triggered:

		triggered = true

		DialogueManager.start([
			"ughh, my flashlight ran-out",
			"Sio: Wait why is a baby here?",
			"Why is it here alone?"
		])
		
		yield(DialogueManager, "dialogue_finished")
		
		$AudioStreamPlayer2D.play()
		$AnimatedSprite.play("jumpscare")
		$AnimationPlayer.play("jumpscare")
		$"../TyanakCry/AudioStreamPlayer2D".playing = false
		
		DialogueManager.start([
			"Sio: Wait What?",
			"The crying stopped."
			
		])
		
		yield($AudioStreamPlayer2D, "finished")

		yield(DialogueManager, "dialogue_finished")


