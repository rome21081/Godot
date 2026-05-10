extends KinematicBody2D

export var speed = 250

var velocity = Vector2()
var is_attacking = false
var invincible = false

func _ready():
	Life.set_enabled(true)

func _physics_process(delta):
	
	if is_knocked:
		knockback_velocity = move_and_slide(knockback_velocity)

		# slow it down over time
		knockback_velocity = knockback_velocity.linear_interpolate(Vector2(), 0.2)

		if knockback_velocity.length() < 10:
			is_knocked = false

		return
	
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
	invincible = true

	$AnimatedSprite.play("attack")
	$Slash.play()

	for body in $Area2D.get_overlapping_bodies():
		if body != self and body.has_method("take_damage"):
			body.take_damage(1)

	yield(get_tree().create_timer(0.2), "timeout")

	invincible = false

	# instead of animation_finished
	yield(get_tree().create_timer(0.3), "timeout")

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

var knockback_velocity = Vector2()
var is_knocked = false

func take_damage(amount):

	if invincible:
		return

	invincible = true
	$hurt.play()
	Life.shake()
	GameState.player_lives -= amount

	print("Lives:", GameState.player_lives)
	
	# 🔥 ALWAYS PUSH LEFT
	knockback_velocity = Vector2(-1000, 0)
	is_knocked = true
	
	modulate = Color(1, 0.4, 0.4)

	yield(get_tree().create_timer(0.2), "timeout")

	modulate = Color(1, 1, 1)

	if GameState.player_lives <= 0:

		DialogueManager.start([
			"You were consumed by the darkness...",
			"You have failed to restore the seal"
		])

		yield(DialogueManager, "dialogue_finished")
		yield(Fade.fade_out(1.0), "completed")

		GameState.player_lives = 3

		get_tree().change_scene("res://Scenes/Title.tscn")

	#yield(get_tree().create_timer(1.0), "timeout")

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


func _on_Cave_body_entered(body):
	if GameState.chapter ==6:

		DialogueManager.start([
			"Entering Cave",
		])

		yield(DialogueManager, "dialogue_finished")
		yield(Fade.fade_out(1.0), "completed")
		get_tree().change_scene("res://Scenes/Houses/Final.tscn")
	else:
		DialogueManager.start([
			"...",
		])
