class_name SuspectItem
extends HBoxContainer

signal blame(suspect: Suspect)

var suspect: Suspect

@onready var portrait: Button = %Button
@onready var label: Label = %Label


func load_suspect(new_suspect: Suspect) -> void:
	suspect = new_suspect
	portrait.icon = suspect.suspect_portrait

	var string := str(suspect.suspect_name, " | ", suspect.suspect_role)
	label.text = string


func blame_suspect() -> void:
	blame.emit(suspect)
