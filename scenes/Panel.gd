extends Panel


# Called when the node enters the scene tree for the first time.
var time: float = 5.0
var minutes: int = 0
var seconds: int = 0
var msec: int = 0

func _process(delta) -> void:
	if(time> 0):
		time -= delta
	else:
		time = 0
	
	$Minutes.text = "%02d:" % minutes
	$Seconds.text = "%02d:" % seconds 
	$Milliseconds.text = "%03d:" % msec
	
	minutes = fmod(time, 3600) /60
	msec = fmod(time, 1) * 100
	seconds = fmod(time, 60)


func stop() -> void:
	set_process(false)

func get_time_formatted() -> String:
	return "%02d:%02d.%03d" % [minutes, seconds, msec]
