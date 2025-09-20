extends CanvasLayer

@onready var timer_label: Label = $TimerLabel
@onready var result_label: Label = $ResultLabel

var race_time: float = 60.0   # 1 minute countdown
var running: bool = true

# ⚡ This should be updated by your race manager (1 = first place, 2 = second, etc.)
var player_place: int = 1
var total_cars: int = 3   # adjust based on number of cars

func _process(delta: float) -> void:
	if running:
		race_time -= delta
		if race_time <= 1:
			race_time = 1
			end_race()
		
		var minutes = int(race_time / 60)
		var seconds = int(race_time) % 60
		var milliseconds = int((race_time - int(race_time)) * 100)
		
		timer_label.text = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

func end_race() -> void:
	running = false
	timer_label.text = "00:00:00"

	if player_place == 1:
		result_label.text = "🏆 YOU WIN!"
	else:
		result_label.text = "❌ YOU LOSE! Place: %d/%d" % [player_place, total_cars]

	result_label.show()
