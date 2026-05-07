extends Area2D

enum State {
	IDLE,
	INTRO,
	QUESTIONING,
	RESULT,
	LOCKED,
	FAIL_WAIT
}

var state = State.IDLE
var scene_path = ""
var player_in_range = false

var post_dialogue_played = false
var interaction_locked = false

var question_index = 0
var correct_answers = 0

var questions = [
	{
		"text": "Why do you continue forward?",
		"choices": [
			{"text": "To protect others", "correct": true},
			{"text": "To gain power", "correct": false}
		]
	},
	{
		"text": "What does the forest value most?",
		"choices": [
			{"text": "Balance", "correct": true},
			{"text": "Strength", "correct": false}
		]
	}
]

# -------------------------
# READY
# -------------------------
func _ready():
	scene_path = get_tree().current_scene.filename

	if not DialogueManager.is_connected("dialogue_finished", self, "_on_dialogue_finished"):
		DialogueManager.connect("dialogue_finished", self, "_on_dialogue_finished")

	reset_runtime_state()

func reset_runtime_state():
	state = State.IDLE
	question_index = 0
	correct_answers = 0
	interaction_locked = false
	post_dialogue_played = false
	player_in_range = false

# -------------------------
# INPUT
# -------------------------
func _process(delta):
	if interaction_locked:
		return

	if !player_in_range:
		return
		
	if DialogueManager.is_active:
		return

	if Input.is_action_just_pressed("ui_accept"):

		if state == State.IDLE:
			start_intro()

		elif state == State.LOCKED and !post_dialogue_played:
			post_dialogue_played = true
			show_post_dialogue()

# -------------------------
# AREA
# -------------------------
func _on_Kapre_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_Kapre_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		state = State.IDLE

# -------------------------
# INTRO
# -------------------------
func start_intro():
	if interaction_locked:
		return
	
	question_index = 0
	correct_answers = 0
	post_dialogue_played = false
	
	state = State.INTRO
	interaction_locked = true

	DialogueManager.start([
		"Kapre: Hmmm...",
		"Answer me, and I will judge your spirit."
	], 1)

# -------------------------
# DIALOGUE FINISHED
# -------------------------
func _on_dialogue_finished(chapter_id):
	interaction_locked = false
	#DialogueManager.reset_state()
	
	if state == State.FAIL_WAIT:
		return

	if state == State.INTRO:
		state = State.QUESTIONING
			
		ask_next_question()
	print("STATE:", state)
	print("Q_INDEX:", question_index)
	print("CORRECT:", correct_answers)
	print("CHAPTER FINISHED RECEIVED:", chapter_id)

# -------------------------
# QUESTIONS
# -------------------------
func ask_next_question():
	if question_index >= questions.size():
		final_judgment()
		return

	var q = questions[question_index]

	DialogueManager.ask_question(
		q["text"],
		q["choices"],
		self,
		"_on_question_answered"
	)

func _on_question_answered(correct):
	if correct:
		correct_answers += 1

	question_index += 1
	ask_next_question()

# -------------------------
# FINAL
# -------------------------
func final_judgment():

	interaction_locked = true

	if correct_answers >= 2:
		state = State.LOCKED
		GameState.puzzle_stage = 2

		DialogueManager.start([
			"Kapre: You listened.",
			"The forest accepts you.",
			"Seek what lies beyond the roots."
		], 2)
		GameState.kapre_approves = true

	else:
		state = State.FAIL_WAIT
		interaction_locked = true

		DialogueManager.start([
			"Kapre: Your spirit is unclear.",
			"Return when you understand the forest."
		], 3)

		print(">>> FAIL REACHED")
		yield(DialogueManager, "dialogue_finished")
		print(">>> AFTER DIALOGUE")
		get_tree().change_scene("res://Scenes/Balete.tscn")
		print(">>> AFTER CHANGE_SCENE")


# -------------------------
# FULL RESET (IMPORTANT FIX)
# -------------------------
func reset_all():
	question_index = 0
	correct_answers = 0
	state = State.IDLE

	interaction_locked = false
	post_dialogue_played = false

	DialogueManager.reset_state()

# -------------------------
# POST LOCK
# -------------------------
func show_post_dialogue():
	if state != State.LOCKED:
		return

	DialogueManager.start([
		"Kapre: You walk with the forest now.",
		"Do not forget what it has shown you."
	], 4)
