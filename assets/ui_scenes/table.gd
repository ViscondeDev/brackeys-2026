extends Control

@export var level_settings: Array[SuspectClaims]

var suspects: Array[Suspect]


func _ready() -> void:
	if not load_settings():
		printerr("Failed to load level")


func load_settings() -> bool:
	for item in level_settings:
		var new_suspect: Suspect = item.suspect
		for statement in item.claims:
			var new_claim := Claim.new()
			new_claim.statement = statement
			new_suspect.claims.append(new_claim)
	return true
