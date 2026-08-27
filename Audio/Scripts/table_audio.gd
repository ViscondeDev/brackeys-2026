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
	pass #Open seection


func on_blame_pressed() -> void:
	pass #Blame someone for real

func _on_close_tab_pressed() -> void:
	pass # Replace with function body.
