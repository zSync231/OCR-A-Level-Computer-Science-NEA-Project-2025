extends Node2D
signal level_complete # this signal emits when a level has been completed.
	
func _on_area_2d_body_entered(body): # this function runs when the player reaches a flag located at the end of each level, in order to complete it.
	if body.name == "Player":
		level_complete.emit() # emits the level_complete signal.
