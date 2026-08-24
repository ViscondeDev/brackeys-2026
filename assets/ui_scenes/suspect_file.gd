@icon("res://addons/at-icons/control/file_pencil.svg")
class_name SuspectFile
extends ColorRect

signal suspect_updated(suspect: Suspect)

var suspect_info: Suspect:
	set(v):
		suspect_info = v
		suspect_updated.emit(v)

@onready var claim_scene: PackedScene = preload("uid://cg8bhn4rbyv8j")
@onready var suspect_name: Label = %Name
@onready var suspect_role: Label = %Role
@onready var suspect_portrait: TextureRect = %Portrait
@onready var suspect_notes: TextEdit = %TextEdit
@onready var suspect_claims: VBoxContainer = %Claims


func setup_suspect_file(suspect: Suspect) -> void:
	visible = true
	for claim in suspect_claims.get_children():
		claim.queue_free()
	suspect_info = suspect
	suspect_name.text = suspect.suspect_name
	suspect_role.text = suspect.suspect_role
	suspect_portrait.texture = suspect.suspect_portrait
	suspect_notes.text = suspect.notes
	populate_claims(suspect.claims)


func populate_claims(claims: Array[Claim]) -> void:
	for i in claims.size():
		var claim := claims[i]
		var new_claim_scene: ClaimScene = claim_scene.instantiate()
		suspect_claims.add_child(new_claim_scene)
		new_claim_scene.statement_label.text = claim.statement
		new_claim_scene.id = i

		var menu_button := new_claim_scene.certainty_menu_button
		menu_button.selected = claim.certainty
		if menu_button.item_selected.connect(update_certainty.bind(i)) == ERR_INVALID_PARAMETER:
			printerr("Failed to connect button")


func update_notes() -> void:
	suspect_info.notes = suspect_notes.text


func update_certainty(option: int, claim: int) -> void:
	suspect_info.claims[claim].certainty = option as Claim.Certainty
