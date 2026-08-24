@icon("res://addons/at-icons/control/file_pencil.svg")
class_name SuspectFile
extends ColorRect

@onready var claim_scene = preload("uid://cg8bhn4rbyv8j")
@onready var suspect_name: Label = %Name
@onready var suspect_role: Label = %Role
@onready var suspect_portrait: TextureRect = %Portrait
@onready var suspect_notes: TextEdit = %TextEdit
@onready var suspect_claims: VBoxContainer = %Claims


func setup_suspect_file(suspect: Suspect) -> void:
	for claim in suspect_claims.get_children():
		claim.queue_free()
	suspect_name.text = suspect.suspect_name
	suspect_role.text = suspect.suspect_role
	suspect_portrait.texture = suspect.suspect_portrait
	populate_claims(suspect.claims)


func populate_claims(claims: Array[Claim]) -> void:
	for claim in claims:
		var new_claim_scene: ClaimScene = claim_scene.instantiate()
		suspect_claims.add_child(new_claim_scene)
		new_claim_scene.statement_label.text = claim.statement
		new_claim_scene.certainty_menu_button.selected = claim.certainty
