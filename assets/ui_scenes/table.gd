extends Control

@export var level_settings: Array[SuspectClaims]

var suspects: Array[Suspect]

@onready var suspect_file: SuspectFile = %SuspectFile
@onready var portraits_container: VBoxContainer = %PortraitsContainer
@onready var suspects_tab: HBoxContainer = %SuspectsTab
@onready var blame_screen: Panel = %BlameScreen
@onready var blame_button: Button = %Blame


func _ready() -> void:
	load_settings()
	setup_suspects_tab()


func load_settings() -> void:
	for i in level_settings.size():
		var item := level_settings[i]
		var new_suspect: Suspect = item.suspect
		for statement in item.claims:
			var new_claim := Claim.new()
			new_claim.statement = statement
			new_suspect.claims.append(new_claim)
		new_suspect.id = i
		suspects.append(new_suspect)


func setup_suspects_tab() -> void:
	for i in suspects.size():
		var suspect := suspects[i]
		add_suspect_to_tab(suspect)
		blame_screen.add_suspect(suspect)


func add_suspect_to_tab(suspect: Suspect) -> void:
	var new_button := Button.new()
	new_button.icon = suspect.suspect_portrait
	portraits_container.add_child(new_button)
	var out: int = new_button.pressed.connect(suspect_file.setup_suspect_file.bind(suspect))
	if out == ERR_INVALID_PARAMETER:
		printerr("Failed to connect button")


func update_suspect_info(suspect: Suspect) -> void:
	suspects[suspect.id] = suspect


func open_suspects_tab() -> void:
	suspects_tab.visible = true
	blame_button.disabled = false


func close_suspects_tab() -> void:
	suspects_tab.visible = false


func open_blame_tab() -> void:
	blame_screen.visible = true


func close_blame_tab() -> void:
	blame_screen.visible = false
