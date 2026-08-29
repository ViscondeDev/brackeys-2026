class_name BlameScreen
extends Panel

signal opened
signal closed
signal final_decision_took

var suspect_item: PackedScene = preload("uid://v4imfh3a4t4g")

@onready var suspect_container: VBoxContainer = %SuspectContainer
@onready var final_judgement_buton: Button = %FinalJudgement


func add_suspect(suspect: Suspect) -> Button:
	var new_suspect_item: SuspectItem = suspect_item.instantiate()
	suspect_container.add_child(new_suspect_item)
	suspect_container.move_child(new_suspect_item, 1)
	new_suspect_item.load_suspect(suspect)
	var button: Button = new_suspect_item.portrait
	return button


func open_blame_tab() -> void:
	visible = true


func close_blame_tab() -> void:
	visible = false


func _on_final_judgement_pressed() -> void:
	final_decision_took.emit()
