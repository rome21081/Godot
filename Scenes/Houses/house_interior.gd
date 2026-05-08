extends Node2D


func _ready():
	get_node("Player/Light2D").visible = false 
	yield(Fade.fade_in(1.0), "completed")

func _on_Exit_body_entered(body):
	yield(Fade.fade_out(1.0), "completed")
	get_tree().change_scene("res://Scenes/Barrio.tscn")
