class_name CrimeSummary
extends Panel

signal opened
signal closed
signal crime_introduced
signal started_blaming

@onready var blame_button: Button = %Blame
@onready var label: Label = %Summary


func close_tab() -> void:
	visible = false
	crime_introduced.emit()
	opened.emit()


func open_tab() -> void:
	visible = true
	closed.emit()


func _on_blame_pressed() -> void:
	started_blaming.emit()
