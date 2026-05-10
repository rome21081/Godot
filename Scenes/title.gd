extends Control

func _ready():
	
	if GameState.chapter == 6:
		$Label.visible = true
		$Label2.visible = false
	elif GameState.chapter >= 2 and GameState.chapter <= 5:
		$Label.visible = false
		$Label2.visible = true
	else:
		$Label.visible = false
		$Label2.visible = false
	
	Life.set_enabled(false)
	yield(Fade.fade_in(1.0), "completed")
	set_process_input(true)
	
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		start_game()
		
func start_game():
	yield(Fade.fade_out(1.0), "completed")
	get_tree().change_scene("res://Scenes/Main.tscn")
