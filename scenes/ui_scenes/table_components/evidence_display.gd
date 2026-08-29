class_name EvidenceDisplay
extends Panel

signal opened
signal closed

@onready var close_up_evidence: TextureRect = %CloseUpEvidence


func open_tab(image: Texture2D) -> void:
	close_up_evidence.texture = image
	visible = true
	opened.emit()


func close_tab() -> void:
	closed.emit()
	visible = false
	print("release blueprint")
