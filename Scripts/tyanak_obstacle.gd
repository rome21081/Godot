extends Node2D

var triggered = false
var looping = false

# true random pool (no weighting)
var attack_pool = ["up1", "down1", "up2", "down2"]

var last_anim = ""


func _ready():
	randomize()


func trigger_attack():
	if looping:
		return

	looping = true
	start_attack_loop()


func start_attack_loop():
	while looping:

		var anim_name = attack_pool[randi() % attack_pool.size()]

		# prevent immediate repeat (horror polish)
		while anim_name == last_anim:
			anim_name = attack_pool[randi() % attack_pool.size()]

		last_anim = anim_name

		$AnimationPlayer.play(anim_name)
		yield($AnimationPlayer, "animation_finished")


func stop_attack():
	looping = false
	$AnimationPlayer.stop()


func _on_TyanakUp1_body_entered(body):
	if body.name == "Player":
		body.take_damage(1)


func _on_TyanakUp2_body_entered(body):
	if body.name == "Player":
		body.take_damage(1)


func _on_TyanakDown1_body_entered(body):
	if body.name == "Player":
		body.take_damage(1)


func _on_TyanakDown2_body_entered(body):
	if body.name == "Player":
		body.take_damage(1)


func _on_CryTrigger_body_entered(body):
	if body.name != "Player":
		return

	DialogueManager.start([
		"The crying suddenly started again..."
	])
	$"../TyanakCry/AudioStreamPlayer2D".play()
	yield(DialogueManager, "dialogue_finished")
	
	get_parent().get_node("TyanakObstacle").trigger_attack()
