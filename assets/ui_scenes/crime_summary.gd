extends Panel

signal crime_introduced

func close_tab() -> void:
	visible = false
	crime_introduced.emit()


func open_tab() -> void:
	visible = true
