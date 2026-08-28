extends Control

func _on_play_pressed() -> void:
	Game.current.load_scene("uid://c00fgjnaetb0i") # table.tscn


func _on_play_mouse_entered() -> void:
	$VBoxContainer/ButtonHover_MainMenu.play()


func _on_button_2_mouse_entered() -> void:
	$VBoxContainer/ButtonHover_MainMenu.play()


func _on_button_3_mouse_entered() -> void:
	$VBoxContainer/ButtonHover_MainMenu.play()
