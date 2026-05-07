extends Node2D

func _ready():
	yield(Fade.fade_in(1.0), "completed")
	get_node("Player/Light2D").visible = false
	
	DialogueManager.start([
				"The Balete Forest.",
				"Your Light Burned Out.",
				"Explore this area for\n something"
			])
