extends Node2D

func _ready():
	if GameState.has_torch:
		queue_free()

func _on_Torch_body_entered(body):
	if body.name == "Player":
		if GameState.has_torch:
			return

		GameState.has_torch = true
		$AnimationPlayer.play("torch")

		DialogueManager.start([
			"You found a torch",
			"The Root might be scared of fire"
		])

		var players = get_tree().get_nodes_in_group("Player")
		if players.size() > 0:
			var light = players[0].get_node_or_null("Light2D")
			if light:
				light.visible = true

func _die():
	queue_free()
