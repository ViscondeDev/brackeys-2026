extends Node2D


func _on_text_edit_text_changed() -> void:
	$TypeNotes.play()


func _on_close_button_pressed() -> void:
	$FileClose.play()


func _on_menu_button_pressed() -> void:
	$MenuButtonClick.play()
