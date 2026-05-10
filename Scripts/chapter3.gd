extends Node2D

func _ready():
	var light = get_node_or_null("YSort/Player/Light2D")
	
	if light:
		light.visible = false
	else:
		print("Light2D not found. Check the node path.")
	yield(Fade.fade_in(1.0), "completed")
	
	yield(get_tree(), "idle_frame")

	if GameState.has_return_position:

		var player = get_tree().get_nodes_in_group("Player")[0]

		player.global_position = GameState.return_position + Vector2(0, 40)

		GameState.has_return_position = false
	
	
	DialogueManager.start([
				"Chapter III\nSmoke Above the Balete.",
				"Your Flashlight Ran out of battery",
				"Explore this area for\n something"
			])
			
	
	
