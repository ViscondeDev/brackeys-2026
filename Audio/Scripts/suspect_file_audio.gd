extends Node2D


func _on_text_edit_text_changed() -> void:
	get_node("TypeNotes").play()


func _on_close_button_pressed() -> void:
	get_node("FileClose").play()
