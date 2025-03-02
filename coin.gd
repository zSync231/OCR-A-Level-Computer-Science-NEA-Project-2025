extends Area2D

signal coin_collect # signal that emits when a coin has been collected.

var score = 0 # initialises the score variable here as one of the factors that determines the score is the number of coins collected.

func _process(delta):
	$AnimatedSprite2D.play("coin_flip") # plays an animation of a coin flipping in mid-air.

func _on_coin_body_entered(body): # this function runs when the player touches a coin in a level.
	if body.name == "Player":
		hide()
		$CoinSound.play()
		$CollisionShape2D.set_deferred("disabled", true) # disables the coin collision, so that there are no 'invisible coins'.
		coin_collect.emit() # emits the signal to the other nodes when a coin has been collected.

# these ten functions load the coins when a specific level has been opened. 
func _on_popups_show_level_1():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$CollisionShape2D.set_deferred("disabled", false) # sets the state 'diabled' to false, meaning that the coins will be counted in the level.

func _on_popups_show_level_2():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_3():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_4():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_5():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_6():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_7():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$CollisionShape2D.set_deferred("disabled", false)
	
func _on_popups_show_level_8():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_9():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_10():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$CollisionShape2D.set_deferred("disabled", false)
