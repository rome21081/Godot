extends Area2D

export(Array, String) var dialogue = [
	"So you've come to my playground!",
	"Enter my Maze if you really \ngot the guts.",
	"Something awaits you at the end!!."
]

var player_in_range = false
var has_talked = false

func _ready():
	pass

func _on_Tikbalang_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_Tikbalang_body_exited(body):
	if body.name == "Player":
		player_in_range = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("ui_accept") and not has_talked:
		has_talked = true
		DialogueManager.start(dialogue)





	
