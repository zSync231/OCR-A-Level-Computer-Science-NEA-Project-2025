extends Node2D
signal jump_powerup_collected # emits when a jump powerup has been collected.

func _on_area_2d_body_entered(body): # runs when the player touches the jump powerup.
	if body.name == "Player":
		jump_powerup_collected.emit()
		hide()
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		$Collect.play()

func _on_player_respawn_powerup(): # respawns all the jump powerups when the player dies.
	show()
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

# the jump powerups are used in levels 1, 4, 6, 8, 9 and 10. these six functions spawn the powerups when any of these levels are entered by the user.
func _on_popups_show_level_1():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout # waits a split second.
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_4():
	if visible == false:
		await get_tree().create_timer(0.000000001).timeout
		show()
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_6():
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
