extends Area2D

func _on_suspect1_body_entered(body):
	if body.name == "Player":

		if GameState.has_garlic:
			DialogueManager.start([
				"Hachuuu....",
				"Put that away I'm alergic on garlic"
			])

		else:
			DialogueManager.start([
				"Hi welcome to our town.",
				"You look good you know."
			])



	
