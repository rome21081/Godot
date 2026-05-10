extends Area2D

func _on_Symbol_body_entered(body):
	if body.name == "Player" and not GameState.found_symbol:
		GameState.found_symbol = true
		
		DialogueManager.start([
			"A strange symbol burned\n into the ground...",
			"It's still warm.",
			"Something is wrong...",
			"Outrun Them"
		])
