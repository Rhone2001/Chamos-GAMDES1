extends Node2D

@export var scroll_speed: float = 200.0
var tracks: Array[TextureRect] = []
var texture_height: float

func _ready():
	# Gather all TextureRects
	for child in get_children():
		if child is TextureRect:
			tracks.append(child)
	
	if tracks.size() == 0:
		return
	
	texture_height = tracks[0].texture.get_height()
	
	# Position them vertically
	for i in range(tracks.size()):
		tracks[i].position.y = -i * texture_height

func _process(delta):
	for track in tracks:
		track.position.y += scroll_speed * delta
		
		# If the track goes below the screen, move it to the top
		if track.position.y >= texture_height:
			var highest_y = get_highest_track_y()
			track.position.y = highest_y - texture_height

func get_highest_track_y() -> float:
	var highest = tracks[0].position.y
	for track in tracks:
		if track.position.y < highest:
			highest = track.position.y
	return highest
