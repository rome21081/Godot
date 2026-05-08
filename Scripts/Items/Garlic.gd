extends Node2D

func _ready():
	if GameState.has_garlic:
		queue_free()


func _on_Garlic_body_entered(body):
	if body.name == "Player":
		GameState.has_garlic = true
		$AnimationPlayer.play("garlic")
		
		DialogueManager.start([
			"You Obtained Garlic",
		])
	
	
func _die():
	queue_free()
