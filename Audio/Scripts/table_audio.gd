class_name SFXManager
extends Node2D

@onready var audio_player: AudioStreamPlayer2D


func _on_suspects_folder_pressed() -> void:
	audio_player = get_node("FileOpen")
	audio_player.play()


func _on_crime_summary_pressed() -> void:
	audio_player = get_node("SummaryOpen")
	audio_player.play()


func _on_blame_opened() -> void:
	audio_player = get_node("BlameOpen")
	audio_player.play()


func on_blame_pressed() -> void:
	pass #Blame someone for real


func _on_close_tab_pressed() -> void:
	audio_player = get_node("SummaryClose")
	audio_player.play()


func _on_close_button_pressed() -> void:
	audio_player = get_node("BlameClose")
	audio_player.play()


#func _new_evidence_or_prop_introduced() -> void:
	#audio_player = get_node("Evidence Introduced")
	#audio_player.play()


func _on_coffee_pressed() -> void:
	audio_player = get_node("Sipping Coffee")
	audio_player.play()


func _on_doors_open() -> void:
	$Cinematic/DoorsOpen.play()

func _on_thunder() -> void:
	$Cinematic/Thunder.play()

func _on_animal_talk(_animal_name) -> void:
	var audio_player = $Cinematic/DoorsOpen
	audio_player.play()

func _on_doors_close() -> void:
	$Cinematic/DoorsClose.play()

func _on_animal_walk() -> void:
	$Cinematic/AnimalWalk.play()

func _on_pointing_hand() -> void:
	$Cinematic/PointingHand.play()

func _on_success() -> void:
	$Cinematic/Success.play()

func _on_failure() -> void:
	$Cinematic/Failure.play()
