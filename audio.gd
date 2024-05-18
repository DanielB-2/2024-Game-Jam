extends Node2D

@onready var sound = $AudioStreamPlayer2D
@onready var track = sound.get_meta("music")
@onready var preloadedTrack = load(track)


# Called when the node enters the scene tree for the first time.
func _ready():
	sound.stream = preloadedTrack
	sound.set_max_polyphony(2)
	sound.play()
