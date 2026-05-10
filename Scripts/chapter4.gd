extends Node2D

func _ready():
	
	get_node("YSort/Player/Light2D").visible = false
	get_node("CanvasModulate").visible = false
	yield(Fade.fade_in(1.0), "completed")
	DialogueManager.connect("dialogue_finished", self, "_on_chap4_finished")
	
	if GameState.aswang_killed:
		DialogueManager.start([
			"The town is now safe thanks to Sio"
		],4)
	
	elif GameState.aswang_found:
		if has_node("suspect2"):
			$suspect2.queue_free()
		DialogueManager.start([
			"Go to the house at the end of town",
			"It's now night time",
			"There's a pregnant woman and a child there",
			"It's possible that the aswang atack them first"
		])
		var light = get_node_or_null("YSort/Player/Light2D")
	
		if light:
			light.visible = false
		get_node("CanvasModulate").visible = true
		
	elif GameState.has_garlic:
		DialogueManager.start([
				"Test out Garlic for towns peoples reaction"
			])
			
	elif GameState.talked_to_captain:
		DialogueManager.start([
				"explore the town",
				"And you can use my house beside the town hall for lodging",
				"report to me imidiately if you found out who it was"	
			])
	
	
	else:
		DialogueManager.start([
				"Chapter IV\nThe Whispers in Barrio.",
				"Head to the Baranggay Hall and\n talk to the chairman"
			])
	
func _on_chap4_finished(chapter_id):
	if chapter_id == 4 and GameState.aswang_killed:
		yield(Fade.fade_out(1.0), "completed")
		
		GameState.chapter = 5
		get_tree().change_scene("res://scenes/Chapel.tscn")
