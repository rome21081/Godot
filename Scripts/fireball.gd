extends Area2D

export var speed = 220
export var turn_speed = 6.0

var player = null
var velocity = Vector2.ZERO

func _ready():
	player = get_tree().get_root().get_node("Final/Player")

func _physics_process(delta):
	if player == null:
		queue_free()
		return

	var target_dir = (player.global_position - global_position).normalized()

	# smooth turning (not instant lock)
	velocity = velocity.linear_interpolate(target_dir * speed, turn_speed * delta)

	global_position += velocity * delta
	
func _on_Fireball_body_entered(body):
	if body.name == "Player":
		body.take_damage(1)
		queue_free()
		
func take_damage(amount):
	queue_free()
