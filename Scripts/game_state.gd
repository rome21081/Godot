extends Node

var player_position = Vector2.ZERO

var player_lives = 3

var tyanak_enlightened = false

var talked_to_captain = false
var has_garlic = false
var has_blessed_oil = false
var aswang_found = false
var aswang_killed = false


var talked_to_babaylan = false
var has_tikbalang_fragment = false
var has_cigar_smoke

var chapter = 1
var found_symbol = false
var hasaan = false
var has_torch = false
var kapre_approves = false
var notes_collected = {
	1: false,
	2: false,
	3: false
}

var puzzle_stage = 1
var max_stage = 3
var points = 0

var checkpoints = {
	1: Vector2(844, 576),
	2: Vector2(1545, 569),
	3: Vector2(2213, 255)
}

var quizzes = {
	1: [
		"What is the Tikbalang?",
		"A. Guardian",
		"B. Trickster",
		"C. Spirit"
	],
	2: [
		"Where does it appear?",
		"A. Bamboo Forest",
		"B. City",
		"C. Sea"
	],
	3: [
		"What does it do?",
		"A. Help travelers",
		"B. Sell Items",
		"C. Confuse paths"
	]
}

func reset_puzzle():
	puzzle_stage = 1
	points = 0

func reset_all():
	chapter = 1
	found_symbol = false
	talked_to_babaylan = false
	hasaan = false
	has_tikbalang_fragment = false
	has_torch = false
	notes_collected = {
		1: false,
		2: false,
		3: false
	}
	puzzle_stage = 1
	points = 0
