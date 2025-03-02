extends Camera2D
var level = 0 # variable to initialise the level chosen. (0 by default)

func _on_popups_load_level(a): # this function adjusts the camera borders based on the level chosen.
	level = a
	if level == 0:
		limit_top = 12800 # the top limit.
		limit_bottom = 13880 # the bottom limit.
		limit_left = 0 # the left limit (due to the way the level node has been created, this value is always 0).
		limit_right = 1920 # the right limit.
	if level == 1:
		limit_top = 0
		limit_bottom = 1000
		limit_left = 0
		limit_right = 10240
	elif level == 2:
		limit_top = 1280
		limit_bottom = 2280
		limit_left = 0
		limit_right = 11328
	elif level == 3:
		limit_top = 2560
		limit_bottom = 3560
		limit_left = 0
		limit_right = 9536
	elif level == 4:
		limit_top = 3840
		limit_bottom = 4840
		limit_left = 0
		limit_right = 11328
	elif level == 5:
		limit_top = 5120
		limit_bottom = 6120
		limit_left = 0
		limit_right = 11584
	elif level == 6:
		limit_top = 6400
		limit_bottom = 7400
		limit_left = 0
		limit_right = 9984
	elif level == 7:
		limit_top = 7680
		limit_bottom = 8680
		limit_left = 0
		limit_right = 11840
	elif level == 8:
		limit_top = 8960
		limit_bottom = 9960
		limit_left = 0
		limit_right = 16640
	elif level == 9:
		limit_top = 10240
		limit_bottom = 11240
		limit_left = 0
		limit_right = 13760
	elif level == 10:
		limit_top = 11520
		limit_bottom = 12520
		limit_left = 0
		limit_right = 19200
	position_smoothing_enabled = false # toggles position camera smoothing.
	await get_tree().create_timer(0.1).timeout # waits 0.1 seconds.
	position_smoothing_enabled = true
	
