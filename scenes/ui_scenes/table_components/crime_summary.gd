class_name CrimeSummary
extends Panel

signal crime_introduced

@onready var blame_button: Button = %Blame
@onready var label: Label = %Summary


func close_tab() -> void:
	visible = false
	crime_introduced.emit()


func open_tab() -> void:
	visible = true
