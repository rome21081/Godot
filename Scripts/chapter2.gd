extends Node2D

func _ready():
	yield(Fade.fade_in(1.0), "completed")
	
