extends CanvasLayer
signal load_level # emitted when a level needs loading.
signal level_pause # emitted to pause the level.
signal level_unpause # emitted to unpause the level
# show level signals: to display the corresponding level to the user.
signal show_level_1
signal show_level_2
signal show_level_3
signal show_level_4
signal show_level_5
signal show_level_6
signal show_level_7
signal show_level_8
signal show_level_9
signal show_level_10
signal level_exit # emitted to exit the level.
var level_playing = false # variable to detect when the level is paused or not.
var paused = false # secondary variable (essentially the same as 'level_playing')
var level = 1 # initialises the current level.
var score = 0 # initialises the player's score.
var coins = 0 # initialises the player's total coins collected in the level.
var coins_fraction = 0 # initialises the fraction of total coins collected in the level.
var enemies = 0 # initialises the number of enemies killed.
var lowest_health = 100 # initialises the lowest amount of health reachd in the level.
var time = 0 # initialises the time on the level.
var level_coins = 64 # initialies the total number of coins in the level (the first level has 64 coins).

func _ready(): # hides the 'level complete' popup.
	$LevelComplete.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): # toggles the display of the 'paused' screen.
	if Input.is_action_just_pressed("pause"):
		if level_playing == true:
			paused = !paused
			if paused == true:
				$Pause.show()
				level_pause.emit()
			elif paused == false:
				$Pause.hide()
				level_unpause.emit()

func _on_finish_level_complete(): # runs when the player completes the level.
	$LevelComplete.show()
	if level == 10: # if the tenth level has been completed, the 'next level' button on the 'level complete' screen is hidden.
		$LevelComplete/NextLevel.hide()
	else:
		$LevelComplete/NextLevel.show()
	$LevelComplete/LevelCompleteSound.play()
	level_playing = false

func _on_hud_send_info(a, b, c, d): # when the player completes a level, the coins, time and health are sent to the 'popups' node as parameters.
	# these properties are used to calculate the data to be displayed on the 'level complete' screen.
	coins = int(a)
	coins_fraction = coins / level_coins
	score += coins
	if coins_fraction == 1:
		score += 150
	elif coins_fraction > 0.5:
		score += 75
	time = c / 10
	if time < 45:
		score += 150
	elif time >= 45 && time < 60:
		score += 75
	elif time >= 60 && time < 75:
		score += 50
	score += enemies * 10
	score -= (100 - d)
	if d == 100:
		score += 200
	elif d > 90:
		score += 150
	elif d > 75:
		score += 100
	if score < 0:
		score = 0
	
	# displays the text on the screen.
	$LevelComplete/CoinsCount.text = str(a) + "/" + str(level_coins)
	$LevelComplete/Timer.text = b
	$LevelComplete/AnimatedSprite2D.play()
	$LevelComplete/Score.text = "Score: " + str(score)

func _on_continue_pressed(): # runs when the 'next level' on the 'level complete' screen has been pressed.
	$LevelComplete.hide() # hides the 'level complete' screen.
	# sets variables back to their defaults.
	score = 0
	coins = 0
	coins_fraction = 0
	enemies = 0
	lowest_health = 100
	time = 0
	level += 1 # increments the level number by one.
	# an if-elif statement is used to change the number of coins and show the specified level to the user.
	if level == 1:
		level_coins = 64
		show_level_1.emit()
	elif level == 2:
		level_coins = 71
		show_level_2.emit()
	elif level == 3:
		level_coins = 60
		show_level_3.emit()
	elif level == 4:
		level_coins = 68
		show_level_4.emit()
	elif level == 5:
		level_coins = 75
		show_level_5.emit()
	elif level == 6:
		level_coins = 58
		show_level_6.emit()
	elif level == 7:
		level_coins = 83
		show_level_7.emit()
	elif level == 8:
		level_coins = 90
		show_level_8.emit()
	elif level == 9:
		level_coins = 96
		show_level_9.emit()
	elif level == 10:
		level_coins = 100
		show_level_10.emit()
	load_level.emit(level)
	level_playing = true

func _on_enemy_increase_level_enemy_count(): # increases the number of enemies by one.
	enemies += 1

func _on_retry_level_pressed(): # runs when the 'retry level' on the 'level complete' screen has been pressed.
	$LevelComplete.hide()
	# resets the variables to their defaults.
	level_playing = true
	load_level.emit(level)
	score = 0
	coins = 0
	coins_fraction = 0
	enemies = 0
	lowest_health = 100
	time = 0
	# an if-elif statement is used to show the correct level, obstacles and items to the user.
	if level == 1:
		show_level_1.emit()
	elif level == 2:
		show_level_2.emit()
	elif level == 3:
		show_level_3.emit()
	elif level == 4:
		show_level_4.emit()
	elif level == 5:
		show_level_5.emit()
	elif level == 6:
		show_level_6.emit()
	elif level == 7:
		show_level_7.emit()
	elif level == 8:
		show_level_8.emit()
	elif level == 9:
		show_level_9.emit()
	elif level == 10:
		show_level_10.emit()

# these ten functions set the 'level' and 'level coins' to their correct values for the 'level complete' screen.
func _on_menus_level_1_pressed():
	level = 1
	level_coins = 64
	level_playing = true
	show_level_1.emit()
	load_level.emit(1)
	
func _on_menus_level_2_pressed():
	level = 2
	level_coins = 71
	level_playing = true
	show_level_2.emit()
	load_level.emit(2)

func _on_menus_level_3_pressed():
	level = 3
	level_coins = 60
	level_playing = true
	show_level_3.emit()
	load_level.emit(3)

func _on_menus_level_4_pressed():
	level = 4
	level_coins = 68
	level_playing = true
	show_level_4.emit()
	load_level.emit(4)

func _on_menus_level_5_pressed():
	level = 5
	level_coins = 75
	level_playing = true
	show_level_5.emit()
	load_level.emit(5)

func _on_menus_level_6_pressed():
	level = 6
	level_coins = 58
	level_playing = true
	show_level_6.emit()
	load_level.emit(6)

func _on_menus_level_7_pressed():
	level = 7
	level_coins = 83
	level_playing = true
	show_level_7.emit()
	load_level.emit(7)

func _on_menus_level_8_pressed():
	level = 8
	level_coins = 90
	level_playing = true
	show_level_8.emit()
	load_level.emit(8)

func _on_menus_level_9_pressed():
	level = 9
	level_coins = 96
	level_playing = true
	show_level_9.emit()
	load_level.emit(9)

func _on_menus_level_10_pressed():
	level = 10
	level_coins = 100
	level_playing = true
	show_level_10.emit()
	load_level.emit(10)

func _on_restart_level_pressed(): # runs when the 'restart level' on the pause screen has been pressed. it does the same as the 'retry level' button.
	$Pause.hide()
	level_playing = true
	paused = false
	level_unpause.emit()
	load_level.emit(level)
	score = 0
	coins = 0
	coins_fraction = 0
	enemies = 0
	lowest_health = 100
	time = 0
	if level == 1:
		show_level_1.emit()
	elif level == 2:
		show_level_2.emit()
	elif level == 3:
		show_level_3.emit()
	elif level == 4:
		show_level_4.emit()
	elif level == 5:
		show_level_5.emit()
	elif level == 6:
		show_level_6.emit()
	elif level == 7:
		show_level_7.emit()
	elif level == 8:
		show_level_8.emit()
	elif level == 9:
		show_level_9.emit()
	elif level == 10:
		show_level_10.emit()

func _on_exit_level_pressed(): # runs when the 'exit level' on the pause screen has been pressed.
	$Pause.hide()
	level_unpause.emit()
	paused = false
	level_playing = false
	level_exit.emit()

func _on_back_button_pressed(): # runs when the 'back' button on the 'level complete' screen has been pressed.
	$LevelComplete.hide()
	level_unpause.emit()
	paused = false
	level_playing = false
	level_exit.emit()
