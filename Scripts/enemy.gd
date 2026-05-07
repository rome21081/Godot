extends KinematicBody2D

export var speed = 80
var player = null
var velocity = Vector2.ZERO
var health = 5

func _ready():
	var players = get_tree().get_nodes_in_group("Player")
	
	if players.size() > 0:
		player = players[0]
	else:
		print("Player not found!")

func _physics_process(delta):
	if player == null:
		return
	
	var dir = (player.global_position - global_position).normalized()
	velocity = dir * speed
	move_and_slide(velocity)

func take_damage(amount):
	health -= amount
	
	if health <= 0:
		queue_free()
