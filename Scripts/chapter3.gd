extends Node2D

func _ready():
	get_node("Player/Light2D").visible = false
	yield(Fade.fade_in(1.0), "completed")
	
	
	DialogueManager.start([
				"Chapter III\nSmoke Above the Balete.",
				"Your Flashlight Ran out of battery",
				"Explore this area for\n something"
			])
