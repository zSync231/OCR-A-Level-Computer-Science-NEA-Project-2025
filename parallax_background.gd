extends ParallaxBackground
var level = 0 # initialises the level the user is currently playing (it is set to 0 when the game is loaded).

func _ready(): # shows the overworld background by default.
	$Overworld.show()
	$Cave.hide()
	$Desert.hide()
	$Volcano.hide()
	$Space.hide()

func _on_popups_load_level(a): # runs when the player loads a level.
	$Overworld.hide() # all the backgrounds are hidden at first.
	$Cave.hide()
	$Desert.hide()
	$Volcano.hide()
	$Space.hide()
	level = a # the parameter stored within the function is assigned to the variable 'level'.
	if level == 1 || level == 2: # an if-elif statement is used to show the correct background for the level (the '||' is the 'or' logic operator in GDScript). 
		$Overworld.show()
	elif level == 3 || level == 4:
		$Cave.show()
	elif level == 5 || level == 6:
		$Desert.show()
	elif level == 7 || level == 8:
		$Volcano.show()
	elif level == 9 || level == 10:
		$Space.show()
