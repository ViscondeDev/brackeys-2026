class_name Level
extends Control

signal suspect_updated

static var current: Level

@export var level_settings: Array[SuspectClaims]
@export var culprit: Suspect
@export var next_level_path: String

@export_multiline var crime_summary: String

var suspects: Array[Suspect]
var is_suspects_folder_released: bool

var _targeted_suspect: Suspect
var _revealed_props: Array[String]

@onready var ending_screen: EndingScreen = %EndingScreen
@onready var suspects_tab: SuspectsTab = %SuspectsTab
@onready var blame_screen: BlameScreen = %BlameScreen
@onready var audio_manager: SFXManager = %TableAudio
@onready var props_animation: AnimationPlayer = %PropsAnimation
@onready var evidence_display: EvidenceDisplay = %EvidenceDisplay
@onready var crime_summary_painel: CrimeSummary = %CrimeSummary


func _ready() -> void:
	suspects_tab.suspect_file.suspect_updated.connect(update_suspect_info)
	load_settings()
	setup_suspects_tab()
	_bind_evidences()

	## AUDIO ##
	var music: AudioStreamPlayer = AudioGlobal.get_node("Music")
	var interactive_music := music.get_stream_playback() as AudioStreamPlaybackInteractive
	interactive_music.switch_to_clip_by_name("Investigation")
	## AUDIO END ##
	await get_tree().create_timer(3).timeout
	props_animation.play("crime_summary")
	#$"CrimeSummary/Evidence Introduced".play()
	crime_summary_painel.label.text = crime_summary


func load_settings() -> void:
	for i in level_settings.size():
		var item := level_settings[i]
		var new_suspect: Suspect = item.suspect
		new_suspect.claims.clear()
		for statement in item.claims:
			var new_claim := Claim.new()
			new_claim.statement = statement
			new_suspect.claims.append(new_claim)
		new_suspect.id = i
		suspects.append(new_suspect)


func setup_suspects_tab() -> void:
	for i in suspects.size():
		var suspect := suspects[i]
		suspects_tab.add_suspect_to_tab(suspect)

		var button: Button = blame_screen.add_suspect(suspect)
		var out := button.pressed.connect(blame.bind(suspect))
		if out == ERR_INVALID_PARAMETER:
			printerr("Failed to connect button")


func update_suspect_info(suspect: Suspect) -> void:
	suspects[suspect.id] = suspect
	suspect_updated.emit()
	print("updated")


func blame(suspect: Suspect) -> void:
	blame_screen.final_judgement_buton.disabled = false
	_targeted_suspect = suspect


func enable_blaming() -> void:
	crime_summary_painel.blame_button.disabled = false


func animate_prop_in(animation: String) -> void:
	print("attempting to play ",animation)
	if not _revealed_props.has(animation):
		props_animation.play(animation)
		_revealed_props.append(animation)


func _release_suspects_folder() -> void:
	if not is_suspects_folder_released:
		props_animation.play("suspects_folder")
		#$"SuspectsFolder/Evidence Introduced".play()
		is_suspects_folder_released = true


func _bind_evidences() -> void:
	for child in get_children():
		if child is Evidence:
			child.pressed.connect(evidence_display.open_tab.bind(child.evidence_close_up))


func _on_final_judgement_pressed() -> void:
	var load_scene_path: String
	if _targeted_suspect.id == culprit.id:
		ending_screen.result.text = "CULPRIT"
		load_scene_path = next_level_path
	else:
		ending_screen.result.text = "INNOCENT"
		load_scene_path = self.scene_file_path

	ending_screen.update_animals(_targeted_suspect)
	ending_screen.ending_animation.play("cinematic_blame")
	var music: AudioStreamPlayer = AudioGlobal.get_node("Music")
	var interactive_music := music.get_stream_playback() as AudioStreamPlaybackInteractive
	music.stream_paused = true
	await ending_screen.ending_animation.animation_finished
	music.stream_paused = false
	Game.current.load_scene(load_scene_path)
