extends CanvasLayer

# all the variables for level and player generation.
var coins = 0
var tenthseconds = 0
var seconds = 0
var minutes = 0
var tenthseconds_display = 0
var seconds_display = 0
var minutes_display = 0
var health = 100
var speed_duration = 20
var speed_time_remaining = 0
var jump_duration = 30
var jump_time_remaining = 0
var sword_durability = 15
var level = 1
var lowest_health = 100
signal increase_speed # emitted when a speed powerup is collected.
signal reset_speed # emitted when the speed powerup runs out.
signal increase_jump # emitted when a jump powerup is collected.
signal reset_jump # emitted when the jump powerup runs out.
signal zero_health # emitted when the player dies.
signal zero_durability # emitted when the player's sword runs out of durability.
signal send_info # a signal for sending data to other nodes in the form of parameters.

func _update_health(a): # updates the player's health.
	if a < lowest_health:
		lowest_health = a
	$HealthCount.text = str(a)
	$HealthBar.value = a
	
func _update_speed_powerup(b): # updates the speed powerup duration.
	$SpeedPotionTimer.text = str(b)
	
func _update_jump_powerup(c): # updates the jump powerup duration.
	$JumpPotionTimer.text = str(c)
	
func _update_sword_durability(d): # updates the sword durability display.
	$SwordDurability.text = str(d)

# called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$coin.play("coin_hud") # plays the coin animation in the HUD.

func _on_coin_collect(): # called when a coin has been collected.
	coins += 1
	$CoinsCount.text = str(coins)


func _on_level_timer_timeout(): # called every one tenth of a second, and updates the timer text.
	tenthseconds += 1
	tenthseconds_display = tenthseconds % 10
	seconds = (tenthseconds / 10) % 60
	minutes = tenthseconds / 600
	if seconds < 10:
		seconds_display = "0" + str(seconds)
	else:
		seconds_display = seconds
	$Timer.text = str(minutes)+ ":" + str(seconds_display) + "." + str(tenthseconds_display)

func _on_death_timer_timeout(): # called after death delay.
	print("death timer finished")
	$LevelTimer.start()

func _on_player_start_death_timer(): # called when player dies.
	print("death timer started")
	$DeathTimer.start()
	$LevelTimer.stop()

func _on_spike_kill_player(): # called when player collides with a spike.
	health = health - (randi() % 10 + 1)
	if health < 100:
		$RegenerationTimer.start() # starts a regeneration timer, that adds health every two seconds.
	if health < 0:
		health = 0
		zero_health.emit()
	_update_health(health) # updates the health display.

func _on_player_reset_health(): # resets the player's health.
	health = 100
	$RegenerationTimer.stop()
	_update_health(health)

func _on_player_void_kill_player(): # runs when player dies due to the void.
	health = 0
	$LevelTimer.stop()
	$RegenerationTimer.stop() # stops the regeneration timer, as the health is reset.
	_update_health(health)

func _on_regeneration_timer_timeout(): # regeneration code.
	health = health + 1 # adds one to the health.
	if health == 100:
		$RegenerationTimer.stop()
	_update_health(health)

func _on_speed_powerup_speed_powerup_collected(): # runs when the player collects the speed powerup.
	speed_time_remaining = speed_duration
	_update_speed_powerup(speed_time_remaining)
	increase_speed.emit()
	$"speed potion".modulate = "#ffffff" # adds the colour to the icon to show that the powerup is active.
	$SpeedTimer.start() # starts the speed timer.
	$SpeedPotionTimer.show() # shows the time left of the speed powerup.

func _on_speed_timer_timeout(): # runs every second whilst the speed powerup is active.
	speed_time_remaining = speed_time_remaining - 1
	_update_speed_powerup(speed_time_remaining)
	if speed_time_remaining == 0:
		$SpeedTimer.stop() # stops the speed timer.
		$SpeedPotionTimer.hide() # hides the duration.
		$"speed potion".modulate = "#ffffff3c" # adds a grey tint to the speed icon to show that the powerup is not active.
		reset_speed.emit()

func _on_jump_powerup_jump_powerup_collected(): # runs when the player collects the jump powerup.
	jump_time_remaining = jump_duration
	_update_jump_powerup(jump_time_remaining)
	increase_jump.emit()
	$"jump potion".modulate = "#ffffff" # adds the colour to the icon to show that the powerup is active.
	$JumpTimer.start() # starts the jump timer.
	$JumpPotionTimer.show() # shows the time left of the jump powerup.

func _on_jump_timer_timeout(): # runs every second whilst the jump powerup is active.
	jump_time_remaining = jump_time_remaining - 1
	_update_jump_powerup(jump_time_remaining)
	if jump_time_remaining == 0:
		$JumpTimer.stop() # stops the jump timer.
		$JumpPotionTimer.hide() # hides the duration.
		$"jump potion".modulate = "#ffffff3c" # adds a grey tint to the speed icon to show that the powerup is not active.
		reset_jump.emit()

func _on_enemy_enemy_damage(): # runs when the enemy deals damage to the player.
	health = health - (randi() % 25 + 1) # the player's health decreases by a random number between 1 and 25 inclusive.
	if health < 100:
		$RegenerationTimer.start()
	if health < 0:
		health = 0
		zero_health.emit()
	_update_health(health) # updates the health display.


func _on_player_change_sword_durability(): # runs when the player uses their sword.
	if sword_durability > 0:
		sword_durability -= 1
		_update_sword_durability(sword_durability) # updates the durability display.
		if sword_durability == 0:
			zero_durability.emit()

func _on_player_show_sword_display(c): # function that shows and hides the sword display based on the 'combat' boolean variable.
	if c == true:
		$Sword.visible = true
		$SwordDurability.visible = true
	else:
		$Sword.visible = false
		$SwordDurability.visible = false

func _on_player_reset_durability(): # runs when the player's sword is reset.
	sword_durability = 15
	_update_sword_durability(sword_durability)
	
func _on_finish_level_complete(): # called when the player completes a level.
	$LevelTimer.stop()
	hide()
	send_info.emit($CoinsCount.text, $Timer.text, tenthseconds, lowest_health)

func _on_popups_level_pause(): # runs when the game is paused. stops the relevant timers.
	$LevelTimer.stop()
	$RegenerationTimer.stop()
	$SpeedTimer.stop()
	$JumpTimer.stop()
	
func _on_popups_level_unpause(): # runs when the game is unpaused. starts the relevant timers.
	$LevelTimer.start()
	if health < 100:
		$RegenerationTimer.start()
	$SpeedTimer.start()
	$JumpTimer.start()

func _on_popups_load_level(a): # runs when the user enters the level. the game loads the level.
	level = a
	$Sword.hide()
	$SwordDurability.hide()
	show()
	# resets the variables to their defaults.
	coins = 0
	$CoinsCount.text = str(coins)
	tenthseconds = 0
	seconds = 0
	minutes = 0
	$LevelTimer.start()
	sword_durability = 15
	health = 100
	_update_health(health)
	$RegenerationTimer.stop()
	_update_sword_durability(sword_durability)
	$JumpTimer.stop()
	$JumpPotionTimer.hide()
	$"jump potion".modulate = "#ffffff3c"
	$SpeedTimer.stop()
	$SpeedPotionTimer.hide()
	$"speed potion".modulate = "#ffffff3c"

func _on_player_respawn_powerup(): # runs when the player dies and they have powerup(s) active.
	$JumpTimer.stop()
	$JumpPotionTimer.hide()
	$"jump potion".modulate = "#ffffff3c"
	$SpeedTimer.stop()
	$SpeedPotionTimer.hide()
	$"speed potion".modulate = "#ffffff3c"
