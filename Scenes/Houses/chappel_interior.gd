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

			"(The crying stops. A voice echoes, small and broken.)",

			"Tyanak: I remember a voice before the darkness.",
			"Tyanak: It did not sound like the forest… it sounded like warmth.",

			"Sio: Who are you talking about?",

			"Tyanak: The one who called me her child.",

			"(pause)",

			"Tyanak: She did not speak my name.",
			"Tyanak: Because I did not have one yet.",

			"Tyanak: I was born under chanting… under old words that should not have been spoken alone.",

			"Sio: The Babaylan…?",

			"(The air grows heavy.)",

			"Tyanak: Yes.",

			"Tyanak: She held me when I first opened my eyes.",
			"Tyanak: But her hands were shaking.",

			"Tyanak: Not with fear…",
			"Tyanak: With regret.",

			"Sio: What did she do to you?",

			"Tyanak: She tried to save me.",
			"Tyanak: But the forest does not return what it takes.",

			"Tyanak: I was not meant to stay in this world.",
			"Tyanak: I was a mistake the ritual refused to erase.",

			"Sio: So you… are her child?",

			"(long silence)",

			"Tyanak: I am what remained of her love… after it was punished.",

			"Tyanak: She still comes to the trees sometimes.",
			"Tyanak: She does not look at me directly.",

			"Tyanak: But I hear her prayers anyway.",

			"Sio: What does she pray for?",

			"Tyanak: That I forget her.",

			"(soft laughter, almost crying)",

			"Tyanak: But I was held once.",
			"Tyanak: And things that are held… do not forget.",
			
			"Sio: What do you want from me?",
			"(The air grows still. The crying returns, but softer now.)",

			"Tyanak: Not fear.",
			"Tyanak: Not escape through violence.",

			"Tyanak: I have chased enough footsteps in the dark.",

			"Sio: Then what is it?",

			"Tyanak: There is a place where voices become quiet.",
			"Tyanak: A place where prayers are no longer broken.",

			"Sio: The altar…",

			"(pause)",

			"Tyanak: Yes.",

			"Tyanak: She once knelt there.",
			"Tyanak: The one who called me hers… before she could no longer look at me.",

			"Tyanak: She placed words into stone and light.",
			"Tyanak: Words that were meant to bind me here.",

			"Sio: You want me to undo it?",

			"(long silence)",

			"Tyanak: I want you to finish what she could not.",

			"Tyanak: Not with weapons.",
			"Tyanak: Not with running.",

			"Tyanak: With prayer.",

			"Tyanak: Stand before the altar.",
			"Tyanak: Speak the words that were forgotten when I was born.",

			"Tyanak: If you truly listen…",
			"Tyanak: you will hear her voice inside them too.",

			"Sio: And if I do it?",

			"(soft breathing, like fading wind)",

			"Tyanak: Then I will no longer remember hunger.",
			"Tyanak: No longer remember being held only to be left.",

			"Tyanak: And I will stop following the sound of kindness… like a wound that never closes.",

			"(very long pause)",

			"Tyanak: Pray for me…",
			"Tyanak: not as a monster…",

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
