class_name SFXManager
extends Node2D

#@onready var audio_player: AudioStreamPlayer


func _on_suspects_folder_pressed() -> void:
	var audio_player = get_node("FileOpen")
	audio_player.play()


func _on_summary_pressed() -> void:
	var audio_player = get_node("SummaryOpen")
	audio_player.play()


func _on_blueprint_pressed() -> void:
	var audio_player = get_node("BlueprintOpen")
	audio_player.play()


func _on_picture_pressed() -> void:
	var audio_player = get_node("PictureOpen")
	audio_player.play()


func _on_blame_opened() -> void:
	var audio_player = get_node("BlameOpen")
	audio_player.play()


func on_blame_pressed() -> void:
	pass #Blame someone for real


func _on_close_tab_pressed() -> void:
	var audio_player = get_node("SummaryClose")
	audio_player.play()


func _on_close_button_pressed() -> void:
	var audio_player = get_node("BlameClose")
	audio_player.play()


#func _new_evidence_or_prop_introduced() -> void:
	#audio_player = get_node("Evidence Introduced")
	#audio_player.position = Vector2(0,0)
	#audio_player.play()


func _on_coffe_pressed() -> void:
	var audio_player = get_node("Sipping Coffee")
	audio_player.play()


func _on_doors_open() -> void:
	var audio_player = get_node("Cinematic/DoorsOpen")
	audio_player.play()

func _on_thunder() -> void:
	var audio_player = get_node("Cinematic/Thunder")
	audio_player.play()

func _on_animal_talk(_animal_name) -> void:
	var audio_player = get_node("Cinematic/DoorsOpen")
	audio_player.play()

func _on_doors_close() -> void:
	var audio_player = get_node("Cinematic/DoorsClose")
	audio_player.play()

func _on_animal_walk() -> void:
	var audio_player = get_node("Cinematic/AnimalWalk")
	audio_player.play()

func _on_pointing_hand() -> void:
	var audio_player = get_node("Cinematic/PointingHand")
	audio_player.play()

func _on_success() -> void:
	var audio_player = get_node("Cinematic/Success")
	audio_player.play()

func _on_failure() -> void:
	var audio_player = get_node("Cinematic/Failure")
	audio_player.play()


#func _on_evidence_audio_with_position(pos: Vector2) -> void:
	#audio_player = get_node("Evidence Introduced")
	#audio_player.position = pos
	#audio_player.play()


func _on_evidence_display_closed() -> void:
	var audio_player = get_node("BlueprintClose")
	audio_player.play()
