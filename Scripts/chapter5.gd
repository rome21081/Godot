extends Node2D

func _ready():
	yield(Fade.fade_in(1.0), "completed")
	
	DialogueManager.start([
				"Chapter V\nThe Crying Baby."
			])
