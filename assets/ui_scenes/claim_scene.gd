@icon("res://addons/at-icons/control/speech_bubble_exclamation.svg")
class_name ClaimScene
extends HBoxContainer

var id: int

@onready var statement_label: Label = %Label
@onready var certainty_menu_button: OptionButton = %OptionButton
