@icon("res://addons/at-icons/mesh/speech_bubble_exclamation.svg")
class_name Claim
extends Resource

enum Certainty {
	FALSE,
	TRUE,
	UNCERTAIN,
}

@export var statement: String
var cenrtainty: Certainty