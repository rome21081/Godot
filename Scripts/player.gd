extends KinematicBody2D

export var speed = 250

var velocity = Vector2()
var is_attacking = false
var invincible = false

func _physics_process(delta):

	if DialogueManager.is_active:
		velocity = Vector2.ZERO

		if $AnimatedSprite.animation == "right":
			$AnimatedSprite.play("idle_right")
		elif $AnimatedSprite.animation == "left":
			$AnimatedSprite.play("idle_left")
		elif $AnimatedSprite.animation == "up":
			$AnimatedSprite.play("idle_up")
		elif $AnimatedSprite.animation == "down":
			$AnimatedSprite.play("idle_down")

		move_and_slide(Vector2.ZERO)
		return

	if is_attacking:
		return

	velocity = Vector2()

	# MOVEMENT
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite.play("right")
		
	elif Input.is_action_just_released("ui_right"):
		$AnimatedSprite.play("idle_right")

	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite.play("left")
		
	elif Input.is_action_just_released("ui_left"):
		$AnimatedSprite.play("idle_left")

	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite.play("down")
		
	elif Input.is_action_just_released("ui_down"):
		$AnimatedSprite.play("idle_down")

	elif Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite.play("up")
	
	elif Input.is_action_just_released("ui_up"):
		$AnimatedSprite.play("idle_up")

	

	velocity = velocity.normalized() * speed
	move_and_slide(velocity)


func _process(delta):
	if GameState.hasaan:
		if Input.is_action_just_pressed("attack"):
			attack()


func attack():
	if is_attacking:
		return

	is_attacking = true

	# play full animation ONCE
	$AnimatedSprite.play("attack")
	$Slash.play()

	# optional damage
	for body in $Area2D.get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(1)

	# wait until animation finishes
	yield($AnimatedSprite, "animation_finished")

	is_attacking = false


func _on_Area2D_body_entered(body):
	if body.name != "Player":
		return

	DialogueManager.start([
		"Entering House",
	])

	yield(DialogueManager, "dialogue_finished")
	yield(Fade.fade_out(1.0), "completed")
	get_tree().change_scene("res://Scenes/Houses/HallInterior.tscn")


func take_damage():

	if invincible:
		return

	invincible = true

	GameState.player_lives -= 1

	print("Lives:", GameState.player_lives)

	# OPTIONAL FLASH EFFECT
	modulate = Color(1, 0.4, 0.4)

	yield(get_tree().create_timer(0.2), "timeout")

	modulate = Color(1, 1, 1)

	# GAME OVER
	if GameState.player_lives <= 0:

		DialogueManager.start([
			"You were consumed by the darkness..."
		])

		yield(DialogueManager, "dialogue_finished")

		yield(Fade.fade_out(1.0), "completed")

		GameState.player_lives = 3

		get_tree().reload_current_scene()

	yield(get_tree().create_timer(1.0), "timeout")

	invincible = false

# Entries
func _on_House1_body_entered(body):
	if body.name != "Player":
		return

	DialogueManager.start([
		"Entering Captain's House",
	])

	yield(DialogueManager, "dialogue_finished")
	yield(Fade.fade_out(1.0), "completed")
	get_tree().change_scene("res://Scenes/Houses/HouseInterior2.tscn")


func _on_House2_body_entered(body):
	if body.name != "Player":
		return

	DialogueManager.start([
		"Entering House",
	])

	yield(DialogueManager, "dialogue_finished")
	yield(Fade.fade_out(1.0), "completed")
	get_tree().change_scene("res://Scenes/Houses/HouseInterior.tscn")

func set_light(state: bool):
	$Light2D.enabled = state


func _on_Chappel_body_entered(body):
	if body.name != "Player":
		return

	DialogueManager.start([
		"Entering Chappel",
	])

	yield(DialogueManager, "dialogue_finished")
	yield(Fade.fade_out(1.0), "completed")
	get_tree().change_scene("res://Scenes/Houses/ChappelInterior.tscn")
