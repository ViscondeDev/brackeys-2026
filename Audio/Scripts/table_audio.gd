extends Node2D

@onready var audio_player: AudioStreamPlayer2D


func _on_suspects_folder_pressed() -> void:
	audio_player = get_node("FileOpen")
	audio_player.play()
