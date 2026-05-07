extends Node

signal chapter_finished(id)

var dialogue_queue = []
var is_active = false
var current_chapter = 1

var waiting_for_choice = false
var choice_target = null
var choice_method = ""
signal dialogue_finished
signal question_finished
var ui = null

# NEW: choice support
var current_choices = []
var choice_callback = null

func _ready():
	print("DialogueManager INSTANCE:", self)
	reset_state()

func start(dialogue, chapter_id = 1):

	# 🔥 HARD RESET EVERYTHING FIRST
	reset_state()

	if ui:
		ui.hide_box()
		ui.clear_choices()

	is_active = true
	current_chapter = chapter_id
	dialogue_queue = dialogue.duplicate()

	ui.show_box()
	show_next()


func show_next():

	if waiting_for_choice:
		return

	if dialogue_queue.size() == 0:
		end()
		return

	var line = dialogue_queue.pop_front()
	ui.update_text(line)


func next():
	if waiting_for_choice:
		return

	show_next()


func end():
	print("DIALOGUE END CALLED")
	is_active = false
	ui.hide_box()
	current_choices.clear()

	emit_signal("dialogue_finished", current_chapter)



func ask_question(text, choices, target, method):

	reset_state() # 🔥 important

	current_choices = choices
	choice_target = target
	choice_method = method
	waiting_for_choice = true

	ui.hide_box()
	ui.clear_choices()

	ui.show_box()
	ui.update_text(text)
	
	ui.choice_box.visible = true
	
	ui.show_choices(choices)


func select_choice(index):

	var is_correct = current_choices[index]["correct"]

	current_choices.clear()
	waiting_for_choice = false

	ui.clear_choices()

	if choice_target != null:
		choice_target.call(choice_method, is_correct)
	
	emit_signal("question_finished")

func reset_state():
	dialogue_queue.clear()
	current_choices.clear()
	is_active = false
	waiting_for_choice = false
	choice_target = null
	choice_method = ""
