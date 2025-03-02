extends Node2D
signal speed_powerup_collected # emitted when a speed powerup has been collected.

func _on_area_2d_body_entered(body): # runs when the player touches the speed powerup.
	if body.name == "Player":
		speed_powerup_collected.emit()
		hide()
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		$Collect.play()

func _on_player_respawn_powerup(): # respawns all the speed powerups when the player dies.
	show()
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

# the speed powerups are used in levels 1, 2, 5, 8, 9 and 10. these six functions spawn the powerups when any of these levels are entered by the user.

func _on_popups_show_level_1():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout # waits a split second.
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_2():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_5():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_8():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)


func _on_popups_show_level_9():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)


func _on_popups_show_level_10():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)
