extends CanvasLayer

class_name HUD 

signal start_game

@onready var score_label := $MarginContainer/HBoxContainer/ScoreLabel
@onready var message := $VBoxContainer/Message
@onready var start_button := $VBoxContainer/StartButton

func show_message(text: String) -> void:
	message.text = text
	message.show()
	$Timer.start()
	
func update_score(value: int) -> void:
	score_label.text = str(value)

func game_over():
	show_message("Talo kana boi")
	await $Timer.timeout
	start_button.show()

func _on_start_button_pressed() -> void:
	start_button.hide()
	start_game.emit()

func _on_timer_timeout() -> void:
	message.hide()
	message.text = ""
