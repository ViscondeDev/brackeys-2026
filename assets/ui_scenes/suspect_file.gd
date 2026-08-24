@icon("res://addons/at-icons/control/file_pencil.svg")
class_name SuspectFile
extends ColorRect

@onready var suspect_name: Label = %Name
@onready var suspect_role: Label = %Role
@onready var suspect_portrait: TextureRect = %Portrait
@onready var suspect_notes: TextEdit = %TextEdit


func setup_suspect_file(suspect: Suspect, _claims: Array[Claim]) -> void:
	suspect_name.text = suspect.suspect_name
	suspect_role.text = suspect.suspect_role
	suspect_portrait.texture = suspect.suspect_portrait
