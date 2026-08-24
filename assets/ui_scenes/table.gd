extends Control

@export var level_settings: Array[SuspectClaims]

var suspects: Array[Suspect]

@onready var suspect_file: SuspectFile = %SuspectFile


func _ready() -> void:
	load_settings()


func load_settings() -> void:
	for item in level_settings:
		var new_suspect: Suspect = item.suspect
		for statement in item.claims:
			var new_claim := Claim.new()
			new_claim.statement = statement
			new_suspect.claims.append(new_claim)
		suspects.append(new_suspect)
	suspect_file.setup_suspect_file(suspects[0])
