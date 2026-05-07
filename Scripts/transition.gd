extends CanvasLayer

onready var rect = $ColorRect

func _ready():
	rect.hide()  # ← prevents auto fade look


func fade_out(duration = 1.0):
	rect.show()

	var tween = Tween.new()
	add_child(tween)

	tween.interpolate_property(rect, "modulate:a", 0, 1, duration)
	tween.start()

	yield(tween, "tween_all_completed")
	tween.queue_free()


func fade_in(duration = 1.0):
	var tween = Tween.new()
	add_child(tween)

	tween.interpolate_property(rect, "modulate:a", 1, 0, duration)
	tween.start()

	yield(tween, "tween_all_completed")

	rect.hide()
	tween.queue_free()
