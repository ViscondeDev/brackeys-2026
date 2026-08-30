class_name BlameScreen
extends Panel

signal opened
signal closed
signal final_decision_took

var suspect_item: PackedScene = preload("uid://v4imfh3a4t4g")

@onready var suspect_container: VBoxContainer = %SuspectContainer
@onready var final_judgement_buton: Button = %FinalJudgement


func add_suspect(suspect: Suspect) -> Button:
	var new_suspect_item: SuspectItem = suspect_item.instantiate()
	suspect_container.add_child(new_suspect_item)
	suspect_container.move_child(new_suspect_item, 1)
	new_suspect_item.load_suspect(suspect)
	var button: Button = new_suspect_item.portrait
	button.flat = false
	## AUDIO ##
	var hover_audio: AudioStreamPlayer2D = AudioGlobal.get_node("ButtonHover").duplicate()
	button.add_child(hover_audio)
	var out: int = button.mouse_entered.connect(_on_mouse_entered.bind(hover_audio))
	if out == ERR_INVALID_PARAMETER:
		printerr("Failed to connect button (AUDIO mouse entered)")
	### AUDIO END ##
	return button


func open_blame_tab() -> void:
	visible = true
	var audio_player: AudioStreamPlayer2D = %TableAudio/BlameOpen
	audio_player.play()
	


func close_blame_tab() -> void:
	visible = false
	var audio_player: AudioStreamPlayer2D = %TableAudio/BlameClose
	audio_player.play()


func _on_final_judgement_pressed() -> void:
	final_decision_took.emit()


func _on_mouse_entered(hover_audio: AudioStreamPlayer2D) -> void:
	hover_audio.play()
