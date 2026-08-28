extends Control

@export var level_settings: Array[SuspectClaims]
@export var culprit: Suspect

var suspects: Array[Suspect]
var is_suspects_folder_released: bool

var _targeted_suspect: Suspect

@onready var suspect_file: SuspectFile = %SuspectFile
@onready var portraits_container: VBoxContainer = %PortraitsContainer
@onready var suspects_tab: HBoxContainer = %SuspectsTab
@onready var blame_screen: BlameScreen = %BlameScreen
@onready var blame_button: Button = %Blame
@onready var audio_manager: SFXManager = %TableAudio
@onready var props_animation: AnimationPlayer = %PropsAnimatinon
@onready var final_judgement_buton: Button = %FinalJudgement


func _ready() -> void:
	load_settings()
	setup_suspects_tab()

	## AUDIO ##
	var music: AudioStreamPlayer = AudioGlobal.get_node("Music")
	var interactive_music := music.get_stream_playback() as AudioStreamPlaybackInteractive
	interactive_music.switch_to_clip_by_name("Investigation")
	## AUDIO END ##
	await get_tree().create_timer(3).timeout
	props_animation.play("crime_summary")


func load_settings() -> void:
	for i in level_settings.size():
		var item := level_settings[i]
		var new_suspect: Suspect = item.suspect
		for statement in item.claims:
			var new_claim := Claim.new()
			new_claim.statement = statement
			new_suspect.claims.append(new_claim)
		new_suspect.id = i
		suspects.append(new_suspect)


func setup_suspects_tab() -> void:
	for i in suspects.size():
		var suspect := suspects[i]
		add_suspect_to_tab(suspect)

		var button: Button = blame_screen.add_suspect(suspect)
		var out := button.pressed.connect(blame.bind(suspect))
		if out == ERR_INVALID_PARAMETER:
			printerr("Failed to connect button")


func add_suspect_to_tab(suspect: Suspect) -> void:
	var new_button := Button.new()
	new_button.icon = suspect.suspect_portrait
	portraits_container.add_child(new_button)
	var out: int = new_button.pressed.connect(suspect_file.setup_suspect_file.bind(suspect))
	if out == ERR_INVALID_PARAMETER:
		printerr("Failed to connect button")

	out = new_button.pressed.connect(audio_manager.on_blame_pressed)
	if out == ERR_INVALID_PARAMETER:
		printerr("Failed to connect button (AUDIO blame pressed)")

	## AUDIO ##
	var hover_audio = AudioGlobal.get_node("ButtonHover").duplicate()
	new_button.add_child(hover_audio)
	out = new_button.mouse_entered.connect(_on_mouse_entered.bind(hover_audio))
	if out == ERR_INVALID_PARAMETER:
		printerr("Failed to connect button (AUDIO mouse entered)")
	### AUDIO END ##


func update_suspect_info(suspect: Suspect) -> void:
	suspects[suspect.id] = suspect


func blame(suspect: Suspect) -> void:
	final_judgement_buton.disabled = false
	_targeted_suspect = suspect


func open_suspects_tab() -> void:
	suspects_tab.visible = true
	blame_button.disabled = false


func close_suspects_tab() -> void:
	suspects_tab.visible = false


func open_blame_tab() -> void:
	blame_screen.visible = true


func close_blame_tab() -> void:
	blame_screen.visible = false


## AUDIO ##
func _on_mouse_entered(hover_audio: AudioStreamPlayer2D) -> void:
	hover_audio.play()


func _release_suspects_folder() -> void:
	if not is_suspects_folder_released:
		props_animation.play("suspects_folder")
		is_suspects_folder_released = true


func _on_final_judgement_pressed() -> void:
	if _targeted_suspect.id == culprit.id:
		print("You got it right")
	else:
		print("Wrong, sorry")
