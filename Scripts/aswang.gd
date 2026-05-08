extends KinematicBody2D

export var speed = 5
var player = null
var velocity = Vector2()
var health = 3

func _ready():
	player = get_parent().get_node("Player")

func _physics_process(delta):
	if player:
		var dir = (player.global_position - global_position).normalized()
		velocity = dir * speed
		move_and_slide(velocity)

func take_damage(amount):
	health -= amount
	if health <= 0:
		queue_free()
		DialogueManager.start([
			"Thank You so much for protecting us"
		])
		GameState.aswang_killed = true
