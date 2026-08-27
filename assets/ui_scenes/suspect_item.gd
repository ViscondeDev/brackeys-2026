class_name SuspectItem
extends HBoxContainer

@onready var portrait: TextureRect = %TextureRect
@onready var label: Label = %Label


func load_suspect(suspect: Suspect) -> void:
	portrait.texture = suspect.suspect_portrait

	var string := str(suspect.suspect_name, " | ", suspect.suspect_role)
	label.text = string
