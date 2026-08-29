@tool
class_name EndingScreen
extends Panel

@onready var ending_animation: AnimationPlayer = %EndingAnimation
@onready var result: Label = %Result
@onready var animal_near: TextureRect = %AnimalNear
@onready var animal_far: TextureRect = %AnimalFar


func update_animals(suspect:Suspect) -> void:
	animal_near.texture = suspect.near
	animal_far.texture = suspect.far


func play_woomp() -> void:
	if result.text == "INNOCENT":
		%FailureWomp.play()
	else :
		%SuccessWomp.play()