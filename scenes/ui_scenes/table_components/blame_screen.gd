class_name BlameScreen
extends Panel

signal opened
signal closed
signal final_decision_took

var suspect_item: PackedScene = preload("uid://v4imfh3a4t4g")

@onready var suspect_container: VBoxContainer = %SuspectContainer
@onready var final_judgement_buton: Button = %FinalJudgement


func add_suspect(suspect: Suspect) -> Button:
	print(suspect.suspect_name)
	var new_suspect_item: SuspectItem = suspect_item.instantiate()
	suspect_container.add_child(new_suspect_item)
	suspect_container.move_child(new_suspect_item, 1)
	new_suspect_item.load_suspect(suspect)
	var button: Button = new_suspect_item.portrait
	button.flat = false
	## AUDIO ##
	var hover_audio: AudioStreamPlayer2D = AudioGlobal.get_node("ButtonHover").duplicate()
	hover_audio.position = button.position
	button.add_child(hover_audio)
	var out: int = button.mouse_entered.connect(_on_mouse_entered.bind(hover_audio))
	if out == ERR_INVALID_PARAMETER:
		printerr("Failed to connect button (AUDIO mouse entered)")
	
	var pressed_audio: AudioStreamPlayer2D = AudioGlobal.get_node("MenuButtonClick").duplicate()
	pressed_audio.position = button.position
	pressed_audio.volume_db = pressed_audio.volume_db + 3
	button.add_child(pressed_audio)
	out = button.pressed.connect(_on_blame_button_pressed.bind(pressed_audio, suspect.suspect_name))
	if out == ERR_INVALID_PARAMETER:
		printerr("Failed to connect button (AUDIO mouse pressed)")
	
	#audio_node_name = "TableAudio/Animals/" + suspect.suspect_name
	#audio_player_animal = %TableAudio/Animals/Sherlock
	#print(audio_player_animal)
	#audio_player_animal.position = button.position
	#button.add_child(pressed_audio)
	#var timer = get_tree().create_timer(0.15)
	#timer.timeout.connect(_delayed_play.bind(audio_player_animal))
	
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


func _on_blame_button_pressed(pressed_audio: AudioStreamPlayer2D, name: String) -> void:
	%TableAudio/BlameSelect.play()
	pressed_audio.play()
	
	var audio_player_animal = %TableAudio.get_node("Animals/" + name)
	print(audio_player_animal)
	print(name)
	audio_player_animal.position = pressed_audio.position
	var timer = get_tree().create_timer(0.15)
	timer.timeout.connect(_delayed_play.bind(audio_player_animal))

## AUDIO ##
func _delayed_play(audio_player: AudioStreamPlayer2D) -> void:
	audio_player.play()
## AUDIO END##
