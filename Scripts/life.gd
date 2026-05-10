extends CanvasLayer

onready var hearts = [
	$Hearts/Heart1,
	$Hearts/Heart2,
	$Hearts/Heart3,
	$Hearts/Heart4,
	$Hearts/Heart5
]

var shake_time = 0.0
var shake_strength = 6
var original_pos = Vector2()

func _ready():
	original_pos = $Hearts.rect_position

func _process(delta):
	if not enabled:
		return
	
	update_hearts()
	update_shake(delta)

func update_hearts():
	var lives = GameState.player_lives

	for i in range(hearts.size()):
		if i < lives:
			hearts[i].visible = true
		else:
			hearts[i].visible = false

func shake():
	shake_time = 0.2
	
func update_shake(delta):

	if shake_time > 0:
		shake_time -= delta

		$Hearts.rect_position = original_pos + Vector2(
			rand_range(-shake_strength, shake_strength),
			rand_range(-shake_strength, shake_strength)
		)
	else:
		$Hearts.rect_position = original_pos

var enabled = false

func set_enabled(value):
	enabled = value
	visible = value
