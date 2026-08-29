@tool
class_name EndingScreen
extends Panel

signal doors_open
signal thunder
#signal animal_talk
signal doors_close
signal animal_walk
signal pointing_hand

var audio_player: AudioStreamPlayer

#signal success
#signal failure

@onready var ending_animation: AnimationPlayer = %EndingAnimation
@onready var result: Label = %Result
@onready var animal_near: TextureRect = %AnimalNear
@onready var animal_far: TextureRect = %AnimalFar

## AUDIO ##
@onready var audio_suspect_name: String
## AUDIO END ##


func update_animals(suspect: Suspect) -> void:
	animal_near.texture = suspect.near
	animal_far.texture = suspect.far
	audio_suspect_name = suspect.suspect_name


func play_woomp() -> void:
	var music: AudioStreamPlayer = AudioGlobal.get_node("Music")
	var interactive_music := music.get_stream_playback() as AudioStreamPlaybackInteractive
	if result.text == "INNOCENT":
		#%FailureWomp.play()
		pass
		#interactive_music.switch_to_clip_by_name("Failure")
		audio_player = AudioGlobal.get_node("Cinematic/Failure")
		audio_player.play()
	else:
		#%SuccessWomp.play()
		interactive_music.switch_to_clip_by_name("Success")
		audio_player = AudioGlobal.get_node("Cinematic/Success")
		audio_player.play()


func _on_doors_open() -> void:
	audio_player = AudioGlobal.get_node("Cinematic/DoorsOpen")
	audio_player.play()
	doors_open.emit()


func _on_animal_talk() -> void:
	audio_player = AudioGlobal.get_node("Cinematic/Animal/" + audio_suspect_name)
	audio_player.play()


func _on_thunder() -> void:
	audio_player = AudioGlobal.get_node("Cinematic/Thunder")
	audio_player.play()
	thunder.emit()


func _on_doors_close() -> void:
	audio_player = AudioGlobal.get_node("Cinematic/DoorsClose")
	audio_player.play()
	doors_close.emit()


func _on_animal_walk() -> void:
	audio_player = AudioGlobal.get_node("Cinematic/AnimalWalk")
	audio_player.play()
	animal_walk.emit()


func _on_pointing_hand() -> void:
	audio_player = AudioGlobal.get_node("Cinematic/PointingHand")
	audio_player.play()
	pointing_hand.emit()
