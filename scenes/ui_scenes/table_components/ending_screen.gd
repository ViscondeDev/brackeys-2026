@tool
class_name EndingScreen
extends Panel

signal doors_open
signal thunder
signal animal_talk
signal doors_close
signal animal_walk
signal pointing_hand

signal success
signal failure

@onready var ending_animation: AnimationPlayer = %EndingAnimation
@onready var result: Label = %Result
@onready var animal_near: TextureRect = %AnimalNear
@onready var animal_far: TextureRect = %AnimalFar


func update_animals(suspect: Suspect) -> void:
	animal_near.texture = suspect.near
	animal_far.texture = suspect.far


func play_woomp() -> void:
	if result.text == "INNOCENT":
		%FailureWomp.play()
	else:
		%SuccessWomp.play()


func _on_doors_open() -> void:
	doors_open.emit()


func _on_thunder() -> void:
	thunder.emit()


func _on_doors_close() -> void:
	doors_close.emit()


func _on_animal_walk() -> void:
	animal_walk.emit()


func _on_pointing_hand() -> void:
	pointing_hand.emit()
