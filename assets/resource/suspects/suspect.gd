@icon("res://addons/at-icons/mesh/paw_print.svg")
class_name Suspect
extends Resource

@export var suspect_name: String
@export var suspect_portrait: Texture2D
@export var suspect_role: String

var claims: Array[Claim]
var notes: String
var id: int
