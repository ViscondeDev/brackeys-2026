extends HBoxContainer

signal opened
signal closed

@onready var suspect_file: SuspectFile = %SuspectFile
@onready var portraits_container: VBoxContainer = %PortraitsContainer
@onready var audio_manager: SFXManager = %TableAudio


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


## AUDIO ##
func _on_mouse_entered(hover_audio: AudioStreamPlayer2D) -> void:
	hover_audio.play()


func _open_suspects_tab() -> void:
	print("Opened")
	visible = true
	opened.emit()


func _close_suspects_tab() -> void:
	visible = false
	closed.emit()
