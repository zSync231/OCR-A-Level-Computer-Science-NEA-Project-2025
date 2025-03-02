extends CharacterBody2D

var SPEED = 300.0 # constant speed value for the player.
var JUMP_VELOCITY = -600.0 # constant jump velocity value for the player (it is negative because of gravity).
var zero_health = false # variable used to track wheather the player has died or not.
var level_paused = false # variable used to track wheather the level has been paused or not.
# initialises relevant player signals.
signal start_death_timer
signal stop_level_timer
signal void_kill_player
signal reset_health
signal enemy_combat_toggle
signal change_sword_durability
signal show_sword_display
signal reset_durability
signal respawn_powerup
var speed_increased = false # tracks if a speed powerup is active.
var jump_increased = false # tracks if a jump powerup is active.
var respawn_x = 32 # default respawn x coordinate.
var respawn_y = 12838 # default respawn y coordinate.
var combat = false # tracks if the player has their sword equipped or not.
var player_x # initialises current x position variable.
var player_y # initialises current y position variable.
var gravity = 980 # gravity variable.
var level = 1 # initialises current level.
var level_void_y = 1151 # the y coordinate used to indicate the 'void'.

func _ready(): # spawns the player to the default coordinates when the game is loaded (the player won't be seen).
	position.x = 32
	position.y = 12838
	$AnimatedSprite2D.play("falling_right")
	if is_on_floor():
		$AnimatedSprite2D.play("standing_right")

func _physics_process(delta):
	
	# adds the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# handles the jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if jump_increased == true:
			$JumpSound.play()

	var direction = Input.get_axis("move_left", "move_right") # gets the input direction and handle the movement/deceleration.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_pressed("move_right") and is_on_floor(): # right key pressed and is on the ground
		$AnimatedSprite2D.play("walk_right")
	elif Input.is_action_pressed("move_left") and is_on_floor(): # left key pressed and is on the ground
		$AnimatedSprite2D.play("walk_left")
	elif Input.is_action_just_released("move_right") and is_on_floor(): # right key released and is on the ground
		$AnimatedSprite2D.play("standing_right")
	elif Input.is_action_just_released("move_left") and is_on_floor(): # left key released and is on the ground
		$AnimatedSprite2D.play("standing_left")
	elif Input.is_action_pressed("move_right") and velocity.y < 0: # right key pressed and jumps on the ground
		$AnimatedSprite2D.play("jumping_right")
	elif Input.is_action_pressed("move_left") and velocity.y < 0: # left key pressed and jumps on the ground
		$AnimatedSprite2D.play("jumping_left")
	elif Input.is_action_pressed("move_right") and velocity.y > 0: # right key pressed and falls on the ground
		$AnimatedSprite2D.play("falling_right")
	elif Input.is_action_pressed("move_left") and velocity.y > 0: # left key pressed and falls on the ground
		$AnimatedSprite2D.play("falling_left")
	elif is_on_floor() and $AnimatedSprite2D.animation == "falling_right" or $AnimatedSprite2D.animation == "jumping_right":
		$AnimatedSprite2D.play("standing_right")
	elif is_on_floor() and $AnimatedSprite2D.animation == "falling_left" or $AnimatedSprite2D.animation == "jumping_left":
		$AnimatedSprite2D.play("standing_left")
	
	move_and_slide()
	
	if position.y > level_void_y and position.y < level_void_y + 30: # this code runs if the player falls into the 'void'.
		zero_health = true
		SPEED = 0
		JUMP_VELOCITY = 0
		void_kill_player.emit() # kills the player.
		$CollisionShape2D.set_deferred("disabled", true)
		print("player killed") # prints a message for debugging purposes.
		print(position.y)
		hide()
		$CollisionShape2D.set_deferred("disabled", false)
		$DeathSound.play()
		await get_tree().create_timer(0.1).timeout # uses four wait commands that form part of the player damage animation. the player 'blinks' every time it takes damage.
		show()
		await get_tree().create_timer(0.1).timeout
		hide()
		await get_tree().create_timer(0.1).timeout
		show()
		await get_tree().create_timer(0.1).timeout
		hide()
		if zero_health == true:
			start_death_timer.emit()
		else:
			await get_tree().create_timer(0.1).timeout
			show()
		
		
	if Input.is_action_just_pressed("sword") && level_paused == false: # toggles the sword when a key is pressed.
		$Sprite2D.visible = !$Sprite2D.visible
		combat = !combat
		enemy_combat_toggle.emit(combat)
		show_sword_display.emit(combat)
		
	if Input.is_action_just_pressed("attack") && combat && level_paused == false: # decrements the sword's durability if the player attacks.
		change_sword_durability.emit()

func _on_spike_kill_player(): # this function runs when the player comes into contact with a spike.
	hide()
	$DeathSound.play()
	await get_tree().create_timer(0.1).timeout
	show()
	await get_tree().create_timer(0.1).timeout
	hide()
	await get_tree().create_timer(0.1).timeout
	show()
	await get_tree().create_timer(0.1).timeout
	hide()
	if zero_health == true:
		start_death_timer.emit()
	else:
		await get_tree().create_timer(0.1).timeout
		show()

func _on_death_timer_timeout(): # runs when the death delay (one second) has elapsed. it then respawns the player back to the beginning or the most recently activated checkpoint.
	print("death timer finished")
	position.x = respawn_x # respawns the player back to the stored coordinates.
	position.y = respawn_y
	# resets all variables to their defaults.
	SPEED = 300.0
	JUMP_VELOCITY = -600.0
	speed_increased = false
	jump_increased = false
	respawn_powerup.emit()
	if zero_health == true:
		reset_health.emit()
		zero_health = false
	$Camera2D.position_smoothing_enabled = false
	show()
	$Camera2D.position_smoothing_enabled = true
	$AnimatedSprite2D.play("standing_right")
	if combat == false:
		$Sprite2D.visible = false
	else:
		$Sprite2D.visible = true
	reset_durability.emit()
	
func _on_hud_zero_health(): # runs if the HUD displays zero health.
	print("player killed")
	zero_health = true
	SPEED = 0
	JUMP_VELOCITY = 0
	hide()
	$DeathSound.play()
	await get_tree().create_timer(0.1).timeout
	show()
	await get_tree().create_timer(0.1).timeout
	hide()
	await get_tree().create_timer(0.1).timeout
	show()
	await get_tree().create_timer(0.1).timeout
	hide()
	start_death_timer.emit()


func _on_hud_increase_speed(): # increases the player's speed.
	SPEED = 500.0
	speed_increased = true


func _on_hud_reset_speed(): # resets the player's speed.
	SPEED = 300.0
	speed_increased = false


func _on_hud_increase_jump(): # increases the player's jump.
	JUMP_VELOCITY = -900.0
	jump_increased = true


func _on_hud_reset_jump(): # resets the player's jump.
	JUMP_VELOCITY = -600.0
	jump_increased = false

func _on_checkpoint_change_respawn(a, b): # changes the player's respawn coordinates to the coordinates of the most recently activated checkpoint.
	# the values are passed as parameters.
	respawn_x = a
	respawn_y = b
	print("respawn: (" + str(respawn_x) + "," + str(respawn_y) + ")")
	
func _on_enemy_enemy_damage(): # runs if an enemy deals damage to the player.
	print("player killed")
	hide()
	$EnemyHit.play()
	await get_tree().create_timer(0.1).timeout
	show()
	await get_tree().create_timer(0.1).timeout
	hide()
	await get_tree().create_timer(0.1).timeout
	show()
	await get_tree().create_timer(0.1).timeout
	hide()
	if zero_health == true:
		start_death_timer.emit()
	else:
		await get_tree().create_timer(0.1).timeout
		show()

func _on_finish_level_complete(): # runs when the player completes a level.
	SPEED = 0
	JUMP_VELOCITY = 0
	level_paused = true

func _on_popups_level_pause(): # runs when the user pauses the game.
	level_paused = true
	SPEED = 0
	JUMP_VELOCITY = 0

func _on_popups_level_unpause(): # runs when the user unpauses the game.
	level_paused = false
	SPEED = 300.0
	JUMP_VELOCITY = -600.0
	if speed_increased == true:
		SPEED = 500
	if jump_increased == true:
		JUMP_VELOCITY = -900.0

func _on_popups_load_level(a): # loads the level the user selects. the level spawn coordinates are determined here.
	combat = false
	$AnimatedSprite2D.play("standing_right")
	$Sprite2D.hide()
	enemy_combat_toggle.emit(combat)
	level_paused = false
	level = a # uses the parameter stored within the function.
	SPEED = 300.0
	JUMP_VELOCITY = -600.0
	if level == 1:
		respawn_x = 75
		respawn_y = 871
		level_void_y = 1151 # the void y-level is adjusted with each level.
	elif level == 2:
		respawn_x = 75
		respawn_y = 1959
		level_void_y = 2431
	elif level == 3:
		respawn_x = 75
		respawn_y = 3111
		level_void_y = 3711
	elif level == 4:
		respawn_x = 75
		respawn_y = 4135
		level_void_y = 4991
	elif level == 5:
		respawn_x = 75
		respawn_y = 5735
		level_void_y = 6271
	elif level == 6:
		respawn_x = 60
		respawn_y = 7077
		level_void_y = 7551
	elif level == 7:
		respawn_x = 60
		respawn_y = 8359
		level_void_y = 8831
	elif level == 8:
		respawn_x = 90
		respawn_y = 9639
		level_void_y = 10111
	elif level == 9:
		respawn_x = 75
		respawn_y = 10919
		level_void_y = 11391
	elif level == 10:
		respawn_x = 75
		respawn_y = 12007
		level_void_y = 12671
	position.x = respawn_x # the respawn values are updated.
	position.y = respawn_y
	reset_durability.emit()
	
func _on_popups_level_exit(): # runs when the 'exit level' button has been pressed. the player spawn is set to default.
	position.x = 32
	position.y = 12838
