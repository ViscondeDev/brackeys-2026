@icon("res://addons/at-icons/control/file_pencil.svg")
class_name SuspectFile
extends NinePatchRect

signal suspect_updated(suspect: Suspect)
signal closed_tab

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

## AUDIO ##
@onready var audio_node_name: String = "SuspectFileAudio/Animals/" + %Name.text
@onready var audio_player_animal: AudioStreamPlayer2D
@onready var audio_player_page: AudioStreamPlayer2D


## AUDIO END ##
func setup_suspect_file(suspect: Suspect) -> void:
	## AUDIO ##
	audio_player_page = get_node("SuspectFileAudio/SuspectFileOpen")
	audio_player_page.play()
	## AUDIO END ##
	visible = true
	for claim in suspect_claims.get_children():
		if claim is not Label:
			claim.queue_free()
	suspect_info = suspect
	suspect_name.text = suspect.suspect_name
	suspect_role.text = suspect.suspect_role
	suspect_portrait.texture = suspect.suspect_portrait
	suspect_notes.text = suspect.notes
	populate_claims(suspect.claims)

	audio_node_name = "SuspectFileAudio/Animals/" + %Name.text
	audio_player_animal = get_node(audio_node_name)
	var timer = get_tree().create_timer(0.15)
	timer.timeout.connect(_delayed_play.bind(audio_player_animal))


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

		## AUDIO ##
		var hover_audio: AudioStreamPlayer2D = AudioGlobal.get_node("ButtonHover").duplicate()
		hover_audio.position = menu_button.position
		menu_button.add_child(hover_audio)
		var out = menu_button.mouse_entered.connect(_on_mouse_entered.bind(hover_audio))
		if out == ERR_INVALID_PARAMETER:
			printerr("Failed to connect button (AUDIO mouse entered)")

		var pressed_audio: AudioStreamPlayer2D = AudioGlobal.get_node("ButtonHover").duplicate()
		pressed_audio.pitch_scale = 0.8
		pressed_audio.position = menu_button.position
		menu_button.add_child(pressed_audio)
		out = menu_button.pressed.connect(_on_menu_button_pressed)
		if out == ERR_INVALID_PARAMETER:
			printerr("Failed to connect button (AUDIO mouse pressed)")
		### AUDIO END ##


func update_notes() -> void:
	suspect_info.notes = suspect_notes.text


func update_certainty(option: int, claim: int) -> void:
	suspect_info.claims[claim].certainty = option as Claim.Certainty
	get_node("SuspectFileAudio/ClaimChoose").play()


func close_tab() -> void:
	closed_tab.emit()


func _on_mouse_entered(hover_audio: AudioStreamPlayer2D) -> void:
	hover_audio.play()


func _on_menu_button_pressed() -> void:
	#pressed_audio.play()
	AudioGlobal.get_node("ButtonHover").play()


## AUDIO ##
func _delayed_play(audio_player: AudioStreamPlayer2D) -> void:
	audio_player.play()
## AUDIO END##
