extends Area2D

func _on_suspect2_body_entered(body):
	if body.name == "Player":

		
		if GameState.has_garlic and GameState.has_blessed_oil:
			DialogueManager.start([
				"Suspect 2 is trembling",
				"Where did you get that oil, if you tell anyone I'll attack someone again!!"
			])
			GameState.aswang_found = true
			$AnimatedSprite.play("default")
			
		elif GameState.has_garlic:
			DialogueManager.start([
				"I Smell Garlic from you",
				"You know you can get fish from me and cook it with that for flavor"
			])
		
		else:
			DialogueManager.start([
				"Hey there kid, you must be new here and btw I sell fish if you want.",
				"just 120 pesos per kilo."
			])



	
