extends Node2D

var tikbalang_active = false
var kapre_active = false
var aswang_active = false
var tyanak_active = false

var boss_summoned = false

onready var boss = $Boss

func _ready():
	$Boss/santelmo.playing = false
	GameState.hasaan = true
	
	yield(Fade.fade_in(1.0), "completed")
	
	# Hide boss at start
	boss.visible = false
	boss.set_process(false)
	boss.set_physics_process(false)
	
	
	DialogueManager.start([
		"Whispers: Remember how you started",
		"Follow again the path that you tracked"
	])

func check_pedestals():
	
	if tikbalang_active \
	and kapre_active \
	and aswang_active \
	and tyanak_active \
	and not boss_summoned:
		
		summon_boss()

func summon_boss():

	boss_summoned = true

	DialogueManager.start([
		"The four seals resonate...",
		"An evil presence emerges..."
	])

	yield(DialogueManager, "dialogue_finished")

	boss.visible = true
	$Boss/santelmo.playing = true

	$Boss/AnimationPlayer.play("spawn")

	yield($Boss/AnimationPlayer, "animation_finished")

	start_endurance_phase()
	
func start_endurance_phase():

	DialogueManager.start([
		"you dare disturb me going to the overword?, I Santelmo?",
		"Let's play then",
		"Survive or Die!"
	])

	yield(DialogueManager, "dialogue_finished")

	$Boss.start_battle()

	yield(get_tree().create_timer(15.0), "timeout")

	$Boss.stop_battle()
	$Boss/AnimationPlayer.play("despawn")
	$Boss/despawn.play()
	
	DialogueManager.start([
		"The evil presence fades...",
		"You prevented santelmo to enter the overworld."
	])

	yield(DialogueManager, "dialogue_finished")
	
	$Boss.visible = false
	boss.set_process(false)
	boss.set_physics_process(false)
	$Boss/santelmo.playing = false
	
	yield(Fade.fade_out(1.0), "completed")
		
	get_tree().change_scene("res://scenes/Title.tscn")

# TIKBALANG
func _on_Tikbalang_body_entered(body):
	if body.name == "Player":
		
		
		if not tikbalang_active:
			$pedestal.play()
		else:
			return
			
		tikbalang_active = true
		
		check_pedestals()

func _on_Tikbalang_body_exited(body):
	pass

# KAPRE
func _on_Kapre_body_entered(body):
	if body.name == "Player" and tikbalang_active:
		
		if not kapre_active:
			$pedestal.play()
		else:
			return
		
		kapre_active = true
		check_pedestals()
	else:
		return

func _on_Kapre_body_exited(body):
	pass

# ASWANG
func _on_Aswang_body_entered(body):
	if body.name == "Player" and kapre_active:
		
		if not aswang_active:
			$pedestal.play()
		else:
			return
		
		aswang_active = true
		check_pedestals()

func _on_Aswang_body_exited(body):
	pass

# TYANAK
func _on_Tyanak_body_entered(body):
	if body.name == "Player" and aswang_active:
		
		if not tyanak_active:
			$pedestal.play()
		else:
			return
		
		tyanak_active = true
		check_pedestals()

func _on_Tyanak_body_exited(body):
	pass
