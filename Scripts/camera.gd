extends Camera2D



func _ready():
	yield(get_tree(), "idle_frame")
	make_current()
