extends Node2D

func _ready():
	yield(Fade.fade_in(1.0), "completed")
	
	var light = get_node_or_null("YSort/Player/Light2D")
	
	if light:
		light.visible = false
	else:
		print("Light2D not found. Check the node path.")
	
	DialogueManager.start([
		"The Balete Forest.",
		"Your Light Burned Out.",
		"Explore this area for\nsomething"
	])
