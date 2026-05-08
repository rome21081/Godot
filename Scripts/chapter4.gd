extends Node2D

func _ready():
	
	
	get_node("Player/Light2D").visible = false
	get_node("CanvasModulate").visible = false
	yield(Fade.fade_in(1.0), "completed")
	
	DialogueManager.start([
				"Chapter IV\nThe Whispers in Barrio.",
				"Head to the Baranggay Hall and\n talk to the chairman"
			])
	
