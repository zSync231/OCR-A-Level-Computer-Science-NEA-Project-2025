extends CharacterBody2D

# variable initialisation for the enemies
var speed = 100.0
var player_combat = false # detects when the player has their sword eqipped.
var mouse_enter = false # detects if the user's mouse cursor is hovering over an enemy.
var durability = true # detects if the player has any durability (energy) remaining on their sword.
signal enemy_damage # emits when an enemy has taken damage.
signal player_attack # emits when a player attacks.
signal increase_level_enemy_count # emits the number of enemies the player has killed.

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = true # detects if the enemy is facing right.
	
func _ready():
	$AnimatedSprite2D.play("walk") # plays a walking animation for the enemy.
	
func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if !$RayCast2D.is_colliding() && is_on_floor(): # flips the enemy direction if the enemy reaches the edge of a raised platform or the top of a small hill section.
		flip()
	
	velocity.x = speed
	move_and_slide()
	
	if Input.is_action_just_pressed("attack") && player_combat && mouse_enter && durability: # if the criteria here is true, then the enemy is killed.
		print("position: " + str(floor(position.x)) + "," + str(floor(position.y)))
		$AnimatedSprite2D.play("death") # plays a death animation for the enemy.
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		$EnemyKill.play() # plays an enemy kill sound.
		await get_tree().create_timer(0.5).timeout # waits 0.5 seconds.
		hide() # hides the sprite from view.
		increase_level_enemy_count.emit()
		
	if Input.is_action_just_pressed("attack"): # prints into the console for debugging purposes.
		print("player combat: " + str(player_combat))
		print("mouse enter: " + str(mouse_enter))
		print("durability: " + str(durability))

func flip(): # this function flips the enemy in the opposite direction.
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1 # reverses the sprite so that it faces the opposite direction.
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1 # moves the enemy in the opposite direction.
		
func _on_area_2d_area_entered(area): # player loses health when it is hit by enemy.
	if area.name == "PlayerHitbox":
		print("enemy damage")
		enemy_damage.emit() # emits the enemy damange signal.

func _on_player_enemy_combat_toggle(a): # this function toggles the player_combat variable for the enemy based on the combat variable of the player.
	if a == true:
		player_combat = true
	elif a == false:
		player_combat = false

# these two functions toggle the mouse_enter variable.

func _on_area_2d_mouse_entered():
	print("mouse_entered")
	mouse_enter = true

func _on_area_2d_mouse_exited():
	print("mouse_exited")
	mouse_enter = false

# these two functions toggle the durability variable.

func _on_hud_zero_durability():
	durability = false
	
func _on_player_reset_durability():
	durability = true

func _on_popups_level_pause(): # stops the enemies moving when the game is paused.
	speed = 0

func _on_popups_level_unpause(): # makes the enemies when the game is unpaused.
	speed = 100.0
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

# these ten functions initialise the enemy sprites, by playing the walking animation and toggling the collision hitboxes.
func _on_popups_show_level_1():
	if visible == false:
		$AnimatedSprite2D.play("walk")
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_2():
	if visible == false:
		$AnimatedSprite2D.play("walk")
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_3():
	if visible == false:
		$AnimatedSprite2D.play("walk")
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_4():
	if visible == false:
		$AnimatedSprite2D.play("walk")
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_5():
	if visible == false:
		$AnimatedSprite2D.play("walk")
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_6():
	if visible == false:
		$AnimatedSprite2D.play("walk")
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_7():
	if visible == false:
		$AnimatedSprite2D.play("walk")
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_8():
	if visible == false:
		$AnimatedSprite2D.play("walk")
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_9():
	if visible == false:
		$AnimatedSprite2D.play("walk")
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_10():
	if visible == false:
		$AnimatedSprite2D.play("walk")
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)
