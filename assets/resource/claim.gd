@icon("res://addons/at-icons/mesh/speech_bubble_exclamation.svg")
class_name Claim
extends Resource

enum Certainty {
	UNCERTAIN,
	FALSE,
	TRUE,
}

@export var statement: String
var certainty: Certainty