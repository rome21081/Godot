extends Node2D

func _ready():
	var light = get_node_or_null("YSort/Player/Light2D")
	
	if light:
		light.visible = false
	else:
		print("Light2D not found. Check the node path.")
	yield(Fade.fade_in(1.0), "completed")
	
	
	
	
	DialogueManager.start([
				"Chapter III\nSmoke Above the Balete.",
				"Your Flashlight Ran out of battery",
				"Explore this area for\n something"
			])
			
	
	
