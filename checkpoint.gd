extends Node2D
signal change_respawn # signal that is emitted when a player reaches a checkpoint.

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/Enabled.hide() # 
	$Area2D/Disabled.show()

func _on_area_2d_body_entered(body): # this function runs if the player enters a checkpoint body.
	if body.name == "Player":
		$Area2D/Disabled.hide()
		$Area2D/Enabled.show()
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		var x = position.x * 4 # these variables are multiplied by 4, because the 'levels' node is scaled by 4.
		var y = position.y * 4
		print("checkpoint: (" + str(x) + "," + str(y) + ")") # the checkpoint is printed in the console for debugging purposes.
		change_respawn.emit(x, y) # sends a signal to the player node to change the respawn position, by passing the x and y variables as parameters.
		$Area2D/CheckpointSound.play() # plays a sound to indicate that a checkpoint has been activiated.

# these ten functions run when a level has been selected by the user, with one function corresponding to a level. these set all the checkpoints to their disabled state.
func _on_popups_show_level_1():
	await get_tree().create_timer(0.000000001).timeout
	$Area2D/Enabled.hide()
	$Area2D/Disabled.show()
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_2():
	await get_tree().create_timer(0.000000001).timeout
	$Area2D/Enabled.hide()
	$Area2D/Disabled.show()
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	
func _on_popups_show_level_3():
	await get_tree().create_timer(0.000000001).timeout
	$Area2D/Enabled.hide()
	$Area2D/Disabled.show()
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_4():
	await get_tree().create_timer(0.000000001).timeout
	$Area2D/Enabled.hide()
	$Area2D/Disabled.show()
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_5():
	await get_tree().create_timer(0.000000001).timeout
	$Area2D/Enabled.hide()
	$Area2D/Disabled.show()
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_6():
	await get_tree().create_timer(0.000000001).timeout
	$Area2D/Enabled.hide()
	$Area2D/Disabled.show()
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_7():
	await get_tree().create_timer(0.000000001).timeout
	$Area2D/Enabled.hide()
	$Area2D/Disabled.show()
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_8():
	await get_tree().create_timer(0.000000001).timeout
	$Area2D/Enabled.hide()
	$Area2D/Disabled.show()
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_9():
	await get_tree().create_timer(0.000000001).timeout
	$Area2D/Enabled.hide()
	$Area2D/Disabled.show()
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_popups_show_level_10():
	await get_tree().create_timer(0.000000001).timeout
	$Area2D/Enabled.hide()
	$Area2D/Disabled.show()
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
