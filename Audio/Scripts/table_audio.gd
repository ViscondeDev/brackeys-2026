class_name SFXManager
extends Node2D

@onready var audio_player: AudioStreamPlayer2D


func _on_suspects_folder_pressed() -> void:
	audio_player = get_node("FileOpen")
	audio_player.play()


func _on_crime_summary_pressed() -> void:
	audio_player = get_node("FileOpen")
	audio_player.play()


func _on_blame_opened() -> void:
	audio_player = get_node("BlameOpen")
	audio_player.play()


func on_blame_pressed() -> void:
	pass #Blame someone for real

func _on_close_tab_pressed() -> void:
	audio_player = get_node("FileClose")
	audio_player.play()


func _on_close_button_pressed() -> void:
	audio_player = get_node("BlameClose")
	audio_player.play()
