extends Node2D

# Player is this node itself
@onready var player = self

# Assign in Inspector
@export var ai_cars: Array        # Array of Node2D (AI cars)
@export var timer_label: Label
@export var result_label: Label
@export var race_timer: Timer

var player_place = 1  # default 1st place

func _ready():
	# Hide result label at start
	if result_label != null:
		result_label.hide()
	
	# Connect timer signal safely
	if race_timer != null and not race_timer.timeout.is_connected(Callable(self, "_on_RaceTimer_timeout")):
		race_timer.timeout.connect(Callable(self, "_on_RaceTimer_timeout"))

func _process(_delta):
	update_player_place()
	
	if race_timer != null and timer_label != null:
		timer_label.text = str(int(race_timer.time_left)) + "s"

func update_player_place():
	var racers = []

	# Add player
	if player != null:
		racers.append({"node": player, "is_player": true})
	
	# Add AI cars
	for car in ai_cars:
		if car != null:
			racers.append({"node": car, "is_player": false})

	# Sort by y position (smaller y = farther ahead)
	racers.sort_custom(Callable(self, "_compare_y_position"))

	# Find player place
	for i in range(racers.size()):
		if racers[i]["is_player"]:
			player_place = i + 1  # 1 = first place

func _compare_y_position(a, b):
	if a["node"].position.y < b["node"].position.y:
		return -1
	elif a["node"].position.y > b["node"].position.y:
		return 1
	else:
		return 0

func _on_RaceTimer_timeout():
	end_race()

func end_race():
	if result_label == null:
		return

	if player_place == 1:
		result_label.text = "YOU WIN 🏆"
	else:
		result_label.text = "YOU LOSE ❌\nPlace: " + str(player_place)
	
	result_label.show()
