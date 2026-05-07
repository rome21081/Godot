extends Node2D

export(int) var stage_id = 1

func _ready():
	if GameState.notes_collected[stage_id]:
		queue_free()


func _on_Note_body_entered(body):
	if body.name != "Player":
		return

	if GameState.puzzle_stage != stage_id:
		return

	if GameState.notes_collected[stage_id]:
		return

	GameState.notes_collected[stage_id] = true

	$AnimationPlayer.play("note")
	show_quiz()


func show_quiz():
	var q = GameState.quizzes[stage_id]

	DialogueManager.start([
		q[0],
		q[1],
		q[2],
		q[3]
	])
