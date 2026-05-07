extends Area2D

func _ready():
	DialogueManager.connect("dialogue_finished", self, "_on_chap1_finished")

func _on_Babaylan_body_entered(body):
	if body.name == "Player":

		if not GameState.found_symbol:
			DialogueManager.start([
				"You are not ready yet."
			])
			return

		if not GameState.talked_to_babaylan:
			GameState.talked_to_babaylan = true

			DialogueManager.start([
				"You have seen the mark.",
				"The spirits are awakening."
			])
			
func _on_chap1_finished(chapter_id):
	if chapter_id == 1 and GameState.talked_to_babaylan:
		yield(Fade.fade_out(1.0), "completed")
		
		GameState.chapter = 2
		get_tree().change_scene("res://scenes/Forest.tscn")
		
		
