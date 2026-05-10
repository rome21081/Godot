extends Node2D

var talked_to_chanak = false

func _ready():
	get_node("Player/Light2D").visible = false 
	yield(Fade.fade_in(1.0), "completed")
	$AudioStreamPlayer2D.play()
	DialogueManager.connect("dialogue_finished", self, "_on_chap5_finished")
	
	DialogueManager.start([
		"It's the baby again",
		"And it's crying in a corner"
	])
	
	
func _on_Exit_body_entered(body):
	yield(Fade.fade_out(1.0), "completed")
	get_tree().change_scene("res://Scenes/Chapel.tscn")


func _on_BabyTyanak_body_entered(body):
	if not talked_to_chanak:
		talked_to_chanak = true
		DialogueManager.start([
			"Sio: What… are you?",

			"Tyanak: I remember warmth before the darkness.",
			"Tyanak: A voice… calling me her child.",

			"Sio: Who?",

			"Tyanak: The Babaylan.",

			"(pause)",

			"Tyanak: I was born from a ritual that should not have been done alone.",
			"Tyanak: She held me… but her hands shook with regret.",

			"Sio: What did she do?",

			"Tyanak: She tried to save me.",
			"Tyanak: But the forest never returns what it takes.",

			"Tyanak: I was a mistake that stayed alive.",

			"Sio: So you’re her child?",

			"(silence)",

			"Tyanak: I am what remains of her love… punished into form.",

			"Tyanak: She still visits the trees.",
			"Tyanak: She does not look at me… but she prays.",

			"Sio: For what?",

			"Tyanak: That I forget her.",

			"(soft laugh)",

			"Tyanak: But I was held once… and held things do not forget.",

			"Sio: What do you want from me?",

			"Tyanak: Not fear.",
			"Tyanak: Not violence.",

			"Tyanak: There is an altar.",

			"Sio: The altar…",

			"Tyanak: Yes.",
			"Tyanak: She bound me there with forgotten words.",

			"Sio: You want me to undo it?",

			"(long pause)",

			"Tyanak: No.",
			"Tyanak: I want you to finish it.",

			"Tyanak: Not with weapons…",
			"Tyanak: but with prayer.",

			"Tyanak: Stand before the altar.",
			"Tyanak: Speak what was lost when I was born.",

			"Sio: And then?",

			"Tyanak: I will finally rest.",
			"Tyanak: No longer chasing kindness like a wound.",

			"(fade)",

			"Tyanak: Pray for me… not as a monster…",
			"Tyanak: but as something that was never allowed to rest."
		])
	else:
		return


func _on_Pray_body_entered(body):
	if talked_to_chanak and not GameState.tyanak_enlightened:
		GameState.tyanak_enlightened = true
		DialogueManager.start([
			"Sio: Gasps....",
			"Sio: Lord… or whatever listens in this place…",
			"Sio: I ask that you free what is trapped between life and death.",

			"Sio: Let it no longer suffer in hunger or loneliness.",
			"Sio: Let it rest… even if it was never given a chance to live.",

			"Tyanak: ...",
			"Tyanak: That is enough.",
			"I thank you Sio",
			"You are the first ever Friend that i have"
		],5)
		
	else:
		DialogueManager.start([
			"..."
		])

func _on_chap5_finished(chapter_id):
	if chapter_id == 5 and GameState.tyanak_enlightened:
		yield(Fade.fade_out(1.0), "completed")
		
		GameState.chapter = 6
		get_tree().change_scene("res://scenes/Main.tscn")
