extends Area2D

export(int) var stage_id = 1
export(bool) var is_correct_path = false

func _on_Teleporter_body_entered(body):
	if not body.is_in_group("player"):
		return

	# ignore if not current stage
	if stage_id != GameState.puzzle_stage:
		return

	if is_correct_path:
		success()
	else:
		fail(body)


func success():
	GameState.points += 1

	if GameState.puzzle_stage < GameState.max_stage:
		GameState.puzzle_stage += 1

		
	else:
		DialogueManager.start([
			"You've broken the illusion...",
			"The Tikbalang left a gift.",
			"get the fragment."
		])


func fail(player):
	var pos = GameState.checkpoints[GameState.puzzle_stage]
	player.global_position = pos
	
	DialogueManager.start([
		"The path was fake...",
		"You are back where you started.",
		"The forest laughs at you."
	])
	$tikbalaugh.play()
