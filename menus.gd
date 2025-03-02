extends CanvasLayer
# these lines initialise ten signals which omit when the specified level has been selected in the level select screen by the user.
signal level_1_pressed
signal level_2_pressed
signal level_3_pressed
signal level_4_pressed
signal level_5_pressed
signal level_6_pressed
signal level_7_pressed
signal level_8_pressed
signal level_9_pressed
signal level_10_pressed

var page = 1 # initialises the page of the 'how to play' screens.

func _ready(): # shows the title screen when the game is first loaded. 
	$TitleScreen.show()
	$LevelSelect.hide()
	$HowToPlay.hide()
	$Controls.hide()

# the ten functions below emit a signal depending on the button pressed. the level select screen is hidden.
func _on_level_1_pressed():
	$LevelSelect.hide()
	level_1_pressed.emit()

func _on_level_2_pressed():
	$LevelSelect.hide()
	level_2_pressed.emit()

func _on_level_3_pressed():
	$LevelSelect.hide()
	level_3_pressed.emit()

func _on_level_4_pressed():
	$LevelSelect.hide()
	level_4_pressed.emit()

func _on_level_5_pressed():
	$LevelSelect.hide()
	level_5_pressed.emit()

func _on_level_6_pressed():
	$LevelSelect.hide()
	level_6_pressed.emit()

func _on_level_7_pressed():
	$LevelSelect.hide()
	level_7_pressed.emit()

func _on_level_8_pressed():
	$LevelSelect.hide()
	level_8_pressed.emit()

func _on_level_9_pressed():
	$LevelSelect.hide()
	level_9_pressed.emit()

func _on_level_10_pressed():
	$LevelSelect.hide()
	level_10_pressed.emit()

func _on_back_button_pressed(): # this is the function for the 'back' button on the 'level select' screen.
	$LevelSelect.hide()
	$TitleScreen.show()

func _on_play_button_pressed(): # this is the function for the 'play' button on the title screen.
	$TitleScreen.hide()
	$LevelSelect.show()

func _on_popups_level_exit(): # this is the function for the 'exit level' button on the pause screen.
	$TitleScreen.show()
	
func _on_how_to_play_button_pressed(): # thiis is the function for the 'how to play' button on the title screen.
	page = 1 # the user is always sent to the first page initially.
	$TitleScreen.hide()
	$HowToPlay.show()
	$HowToPlay/PreviousButton.hide()
	$HowToPlay/Tutorial2.hide()
	$HowToPlay/Tutorial1.show()
	$HowToPlay/Info.text = "Use the A and D keys to move the player around." # displays the instructional text.
	$HowToPlay/PageNumbers.text = "1/12" # displays the page numbers.
	$HowToPlay/NextButton.show() # shows the button to send the user to the next page.
	

func _on_next_button_pressed(): # runs when the 'next' button is pressed.
	page += 1 # the page number is incremented by one.
	if page == 2: # an if-elif statement is used to check each case and display the correct piece of text and page numbers.
		$HowToPlay/PreviousButton.show()
		$HowToPlay/Tutorial1.hide()
		$HowToPlay/Tutorial2.show()
		$HowToPlay/Info.text = "Press the W or space key to jump."
		$HowToPlay/PageNumbers.text = "2/12"
	elif page == 3:
		$HowToPlay/Tutorial2.hide()
		$HowToPlay/Tutorial3.show()
		$HowToPlay/Info.text = "Collect coins along the way."
		$HowToPlay/PageNumbers.text = "3/12"
	elif page == 4:
		$HowToPlay/Tutorial3.hide()
		$HowToPlay/Tutorial4.show()
		$HowToPlay/Info.text = "Try not to fall in the void!"
		$HowToPlay/PageNumbers.text = "4/12"
	elif page == 5:
		$HowToPlay/Tutorial4.hide()
		$HowToPlay/Tutorial5.show()
		$HowToPlay/Info.text = "This is a checkpoint. You respawn here if you die past it."
		$HowToPlay/PageNumbers.text = "5/12"
	elif page == 6:
		$HowToPlay/Tutorial5.hide()
		$HowToPlay/Tutorial6.show()
		$HowToPlay/Info.text = "Jump boost powerups increase your maximum jump height for thirty seconds."
		$HowToPlay/PageNumbers.text = "6/12"
	elif page == 7:
		$HowToPlay/Tutorial6.hide()
		$HowToPlay/Tutorial7.show()
		$HowToPlay/Info.text = "Speed boost powerups increase your maximum speed for twenty seconds."
		$HowToPlay/PageNumbers.text = "7/12"
	elif page == 8:
		$HowToPlay/Tutorial7.hide()
		$HowToPlay/Tutorial8.show()
		$HowToPlay/Info.text = "Watch out for spikes along the path."
		$HowToPlay/PageNumbers.text = "8/12"
	elif page == 9:
		$HowToPlay/Tutorial8.hide()
		$HowToPlay/Tutorial9.show()
		$HowToPlay/Info.text = "Look out for enemies. They cause more damage!"
		$HowToPlay/PageNumbers.text = "9/12"
	elif page == 10:
		$HowToPlay/Tutorial9.hide()
		$HowToPlay/Tutorial10.show()
		$HowToPlay/Info.text = "To kill an enemy, press the S key to equip your sword."
		$HowToPlay/PageNumbers.text = "10/12"
	elif page == 11:
		$HowToPlay/Tutorial10.hide()
		$HowToPlay/Tutorial11.show()
		$HowToPlay/Info.text = "Whilst the sword is equipped, hover your mouse cursor over the enemy. At the same\ntime, either press Q or left-click the mouse button to kill the enemy in one hit."
		$HowToPlay/PageNumbers.text = "11/12"
	elif page == 12:
		$HowToPlay/NextButton.hide()
		$HowToPlay/Tutorial11.hide()
		$HowToPlay/Tutorial12.show()
		$HowToPlay/Info.text = "To complete the level, you need to reach the flag at the end."
		$HowToPlay/PageNumbers.text = "12/12"

func _on_previous_button_pressed(): # runs when the 'previous' button is pressed.
	page -= 1 # the page number is decremented by one.
	if page == 1: # an if-elif statement is used to check each case and display the text accordingly.
		$HowToPlay/PreviousButton.hide()
		$HowToPlay/Tutorial2.hide()
		$HowToPlay/Tutorial1.show()
		$HowToPlay/Info.text = "Use the A and D keys to move the player around."
		$HowToPlay/PageNumbers.text = "1/12"
	elif page == 2:
		$HowToPlay/Tutorial3.hide()
		$HowToPlay/Tutorial2.show()
		$HowToPlay/Info.text = "Press the W or space key to jump."
		$HowToPlay/PageNumbers.text = "2/12"
	elif page == 3:
		$HowToPlay/Tutorial4.hide()
		$HowToPlay/Tutorial3.show()
		$HowToPlay/Info.text = "Collect coins along the way."
		$HowToPlay/PageNumbers.text = "3/12"
	elif page == 4:
		$HowToPlay/Tutorial5.hide()
		$HowToPlay/Tutorial4.show()
		$HowToPlay/Info.text = "Try not to fall in the void!"
		$HowToPlay/PageNumbers.text = "4/12"
	elif page == 5:
		$HowToPlay/Tutorial6.hide()
		$HowToPlay/Tutorial5.show()
		$HowToPlay/Info.text = "This is a checkpoint. You respawn here if you die past it."
		$HowToPlay/PageNumbers.text = "5/12"
	elif page == 6:
		$HowToPlay/Tutorial7.hide()
		$HowToPlay/Tutorial6.show()
		$HowToPlay/Info.text = "Jump boost powerups increase your maximum jump height for thirty seconds."
		$HowToPlay/PageNumbers.text = "6/12"
	elif page == 7:
		$HowToPlay/Tutorial8.hide()
		$HowToPlay/Tutorial7.show()
		$HowToPlay/Info.text = "Speed boost powerups increase your maximum speed for twenty seconds."
		$HowToPlay/PageNumbers.text = "7/12"
	elif page == 8:
		$HowToPlay/Tutorial9.hide()
		$HowToPlay/Tutorial8.show()
		$HowToPlay/Info.text = "Watch out for spikes along the path."
		$HowToPlay/PageNumbers.text = "8/12"
	elif page == 9:
		$HowToPlay/Tutorial10.hide()
		$HowToPlay/Tutorial9.show()
		$HowToPlay/Info.text = "Look out for enemies. They cause more damage!"
		$HowToPlay/PageNumbers.text = "9/12"
	elif page == 10:
		$HowToPlay/Tutorial11.hide()
		$HowToPlay/Tutorial10.show()
		$HowToPlay/Info.text = "To kill an enemy, press the S key to equip your sword."
		$HowToPlay/PageNumbers.text = "10/12"
	elif page == 11:
		$HowToPlay/NextButton.show()
		$HowToPlay/Tutorial12.hide()
		$HowToPlay/Tutorial11.show()
		$HowToPlay/Info.text = "Whilst the sword is equipped, hover your mouse cursor over the enemy. At the same\ntime, either press Q or left-click the mouse button to kill the enemy in one hit."
		$HowToPlay/PageNumbers.text = "11/12"

func _on_back_button_2_pressed(): # runs when the 'back' button on the 'how to play' screen has been pressed.
	if page == 1: # an if-elif statement is used to check each case and hide the relevant page, and show the title screen.
		$HowToPlay/Tutorial1.hide()
	elif page == 2:
		$HowToPlay/Tutorial2.hide()
	elif page == 3:
		$HowToPlay/Tutorial3.hide()
	elif page == 4:
		$HowToPlay/Tutorial4.hide()
	elif page == 5:
		$HowToPlay/Tutorial5.hide()
	elif page == 6:
		$HowToPlay/Tutorial6.hide()
	elif page == 7:
		$HowToPlay/Tutorial7.hide()
	elif page == 8:
		$HowToPlay/Tutorial8.hide()
	elif page == 9:
		$HowToPlay/Tutorial9.hide()
	elif page == 10:
		$HowToPlay/Tutorial10.hide()
	elif page == 11:
		$HowToPlay/Tutorial11.hide()
	elif page == 12:
		$HowToPlay/Tutorial12.hide()
	$HowToPlay.hide()
	$TitleScreen.show()

func _on_controls_button_pressed(): # runs when the 'controls' button has been pressed on the title screen.
	$TitleScreen.hide()
	$Controls.show()

func _on_back_button_3_pressed(): # runs when the 'back' button on the 'controls' screen has been pressed.
	$Controls.hide()
	$TitleScreen.show()
