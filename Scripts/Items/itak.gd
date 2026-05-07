extends Node2D

func _ready():
	if GameState.hasaan:
		queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		GameState.hasaan = true
		$AnimationPlayer.play("hasaan")
		
		DialogueManager.start([
			"You can now use your Bolo",
		])
	
func _on_AnimationPlayer_animation_finished(name):
	if name =="hasaan":
		$AnimationPlayer.play("hasaan")
	
func _die():
	queue_free()
