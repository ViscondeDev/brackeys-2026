class_name EvidenceDisplay
extends Panel

@onready var close_up_evidence: TextureRect = %CloseUpEvidence


func open_tab(image: Texture2D) -> void:
	close_up_evidence.texture = image
	visible = true


func close_tab() -> void:
	visible = false
