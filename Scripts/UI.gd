extends CanvasLayer

onready var panel = $Panel
onready var vbox = $Panel/VBoxContainer
onready var label = $Panel/VBoxContainer/Label
onready var choice_box = $Panel/VBoxContainer/ChoiceBox

func _ready():
	yield(get_tree(), "idle_frame") # Expected end of statement after expression, got Identifier instead
	DialogueManager.ui = self
	hide_box()
	print("UI INSTANCE:", self)


func show_box():
	panel.visible = true
	panel.raise()


func hide_box():
	panel.visible = false
	choice_box.visible = false
	clear_choices()


func update_text(text):
	label.text = text


# -------------------------
# 🌿 CHOICES (VBox SYSTEM)
# -------------------------
func show_choices(choices):
	clear_choices()

	choice_box.visible = true

	for i in range(choices.size()):
		var btn = Button.new()
		btn.text = choices[i].text
		btn.connect("pressed", self, "_on_choice_pressed", [i])
		choice_box.add_child(btn)

	#choice_box.queue_sort()
		
func _on_choice_pressed(index):
	DialogueManager.select_choice(index)


func clear_choices():
	for c in choice_box.get_children():
		c.queue_free()
		
func _unhandled_input(event):
	if DialogueManager.is_active \
	and !DialogueManager.waiting_for_choice \
	and event.is_action_pressed("ui_accept"):
		DialogueManager.next()
