extends Area2D

func _on_suspect3_body_entered(body):
	if body.name == "Player":

		if GameState.has_garlic:
			DialogueManager.start([
				"You got garlic on you?",
				"I have a special oil for you to saute it with",
				"It's Free no worries"
			])
			GameState.has_blessed_oil = true

		else:
			DialogueManager.start([
				"Welcome to my store.",
				"You want to buy anything?"
			])



	
