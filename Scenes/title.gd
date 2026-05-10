extends Control

func _ready():
	Life.set_enabled(false)
	yield(Fade.fade_in(1.0), "completed")
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		start_game()
		
func start_game():
	yield(Fade.fade_out(1.0), "completed")
	get_tree().change_scene("res://Scenes/Main.tscn")
