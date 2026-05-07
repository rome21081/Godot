extends KinematicBody2D

export var speed = 250

var velocity = Vector2()
var is_attacking = false

func _physics_process(delta):

	if DialogueManager.is_active:
		return

	if is_attacking:
		return

	velocity = Vector2()

	# MOVEMENT
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite.play("right")

	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite.play("left")

	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite.play("down")

	elif Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite.play("up")

	else:
		$AnimatedSprite.play("idle")

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
