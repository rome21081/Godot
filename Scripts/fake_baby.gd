extends Area2D

var player_in_range = false
var triggered = false

func _ready():
	$Light2D.visible = false

func _on_FakeBaby_body_entered(body):

	if body.name == "Player":
		player_in_range = true
		body.set_light(false)


func _on_FakeBaby_body_exited(body):

	if body.name == "Player":
		player_in_range = false


func _process(delta):

	if player_in_range \
	and Input.is_action_just_pressed("ui_accept") \
	and not triggered:

		triggered = true

		start_event()


func start_event():

	DialogueManager.start([
		"ughh, my flashlight ran-out",
		"Sio: Wait why is a baby here?",
		"Why is it here alone?"
	])

	yield(DialogueManager, "dialogue_finished")

	

	$"../TyanakCry/AudioStreamPlayer2D".stop()

	DialogueManager.start([
		"Sio: Wait What?",
		"The crying stopped.",
		"I should get going now"
	])

	yield(DialogueManager, "dialogue_finished")

	# wait 0.5 seconds after dialogue closes
	yield(get_tree().create_timer(.75), "timeout")
	
	$Light2D.visible = true
	
	$AudioStreamPlayer2D.play()
	$AnimatedSprite.play("jumpscare")
	$AnimationPlayer.play("jumpscare")
	
	# optional: wait for scream sound to finish
	yield($AudioStreamPlayer2D, "finished")
	$Light2D.visible = false
