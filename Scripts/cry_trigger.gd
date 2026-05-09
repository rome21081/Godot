extends Area2D

func _on_CryTrigger_body_entered(body):

	if body.name != "Player":
		return

	DialogueManager.start([
		"The crying suddenly started again..."
	])
	
	yield(DialogueManager, "dialogue_finished")

	
	get_parent().get_node("..").trigger_attack()
