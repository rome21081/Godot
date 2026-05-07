extends Node2D

func _ready():
	DialogueManager.connect("dialogue_finished", self, "_on_chap2_finished")

func _on_Hair_body_entered(body):
	if body.name == "Player":
		GameState.has_tikbalang_fragment = true
		$AnimationPlayer.play("hair")
		
		DialogueManager.start([
			"You've obtained the tikbalang's hair",
			"You may now proceed..."
		], 2)

func _on_chap2_finished(chapter_id):
	if chapter_id ==2:
		print("Chapter 2 Finished")
		yield(Fade.fade_out(1.0), "completed")
		GameState.chapter = 3
		get_tree().change_scene("res://scenes/Balete.tscn")
