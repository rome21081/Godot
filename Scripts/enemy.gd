extends KinematicBody2D

export var speed := 85
export var stop_distance := 18
export var damage := 1
export var attack_cooldown := 1.0

var player = null
var velocity := Vector2.ZERO
var can_attack := true
var player_in_attack_area := false

func _ready():
	add_to_group("Enemies")

	player = get_tree().get_root().find_node("Player", true, false)

	if has_node("AttackArea"):
		$AttackArea.connect("body_entered", self, "_on_AttackArea_body_entered")
		$AttackArea.connect("body_exited", self, "_on_AttackArea_body_exited")

func _physics_process(delta):
	if player == null:
		player = get_tree().get_root().find_node("Player", true, false)
		return

	chase_player()

	if player_in_attack_area:
		attack_player()

func chase_player():
	var direction = player.global_position - global_position
	var distance = direction.length()

	if distance > stop_distance:
		velocity = direction.normalized() * speed
		move_and_slide(velocity)
	else:
		velocity = Vector2.ZERO

func attack_player():
	if not can_attack:
		return

	can_attack = false

	if player != null and player.has_method("take_damage"):
		player.take_damage(damage)

	yield(get_tree().create_timer(attack_cooldown), "timeout")
	can_attack = true

func _on_AttackArea_body_entered(body):
	if body.name == "Player":
		player_in_attack_area = true

func _on_AttackArea_body_exited(body):
	if body.name == "Player":
		player_in_attack_area = false
