extends Area2D

var triggered = false	

func _on_TyanakCry_body_entered(body):
	if body.name != "Player":
		return

	if triggered:
		return

	triggered = true

	$AudioStreamPlayer2D.play()

	DialogueManager.start([
		"A baby is crying nearby...",
		"The sound is coming from the forest."
	])
