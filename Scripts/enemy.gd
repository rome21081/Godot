extends KinematicBody2D

export var speed = 150
export var stop_distance = 18
export var damage = 1
export var attack_cooldown = 1.0

var player = null
var velocity = Vector2.ZERO
var can_attack = true
var player_in_attack_area = false


func _ready():
	add_to_group("Enemies")

	# SAFE player fetch using group
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		player = players[0]



export var health = 1

var knockback = Vector2()

func _physics_process(delta):

	if knockback.length() > 0:
		move_and_slide(knockback)
		knockback = knockback.linear_interpolate(Vector2(), 0.2)
		return

	chase_player()

	if player_in_attack_area:
		attack_player()

func take_damage(amount):

	health -= amount

	modulate = Color(1, 0.3, 0.3)

	# push away from player
	if player:
		knockback = (global_position - player.global_position).normalized() * 300

	yield(get_tree().create_timer(0.1), "timeout")

	modulate = Color(1, 1, 1)

	if health <= 0:
		queue_free()


func chase_player():
	var direction = player.global_position - global_position
	var distance = direction.length()

	if distance > stop_distance:
		velocity = direction.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide(velocity)


func attack_player():
	if not can_attack:
		return

	can_attack = false

	if player and player.has_method("take_damage"):
		player.take_damage(damage)

	yield(get_tree().create_timer(attack_cooldown), "timeout")

	can_attack = true


func _on_AttackArea_body_entered(body):
	if body.is_in_group("Player"):
		player_in_attack_area = true


func _on_AttackArea_body_exited(body):
	if body.is_in_group("Player"):
		player_in_attack_area = false
