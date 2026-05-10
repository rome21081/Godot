extends Area2D

func _on_Attack_body_entered(body):

	if body.name == "Player":
		body.take_damage(1)
