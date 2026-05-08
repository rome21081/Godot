extends Node2D

func _ready():
	DialogueManager.connect("dialogue_finished", self, "_on_chap3_finished")

func _on_CigarSmoke_body_entered(body):
	if body.name == "Player" and GameState.kapre_approves:
		GameState.has_cigar_smoke = true
		
		DialogueManager.start([
			"You've obtained a kapre's\n cigar smoke containing ashes ",
			"You may now proceed..."
		], 3)

func _on_chap3_finished(chapter_id):
	if chapter_id ==3:
		print("Chapter 3 Finished")
		yield(Fade.fade_out(1.0), "completed")
		GameState.chapter = 3
		get_tree().change_scene("res://scenes/Barrio.tscn")



