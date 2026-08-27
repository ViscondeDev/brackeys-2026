extends Panel

var suspect_item: PackedScene = preload("uid://v4imfh3a4t4g")

@onready var suspect_container: VBoxContainer = %SuspectContainer


func add_suspect(suspect: Suspect) -> void:
	var new_suspect_item: SuspectItem = suspect_item.instantiate()
	suspect_container.add_child(new_suspect_item)
	new_suspect_item.load_suspect(suspect)
