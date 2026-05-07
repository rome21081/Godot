extends Area2D

export(Array, String) var dialogue = [
	"The babaylan used to\n protect this place.",
	"But the seal… it’s weakening now.",
	"If it breaks completely,\n we’re all done for.",
	"It seems you can't use your Bolo,\n get the wetstone beside me",
	"Use it to protect yourself and find the babaylan"
]

var player_in_range = false
var has_talked = false

func _ready():
	pass

func _on_NPC_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_NPC_body_exited(body):
	if body.name == "Player":
		player_in_range = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("ui_accept") and not has_talked:
		has_talked = true
		DialogueManager.start(dialogue)
