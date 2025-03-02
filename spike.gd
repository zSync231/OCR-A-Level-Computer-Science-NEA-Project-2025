extends Node2D

signal kill_player # emitted when the player collides with a spike.

func _on_area_2d_body_entered(body): # runs when the player comes into contact with a spike.
	if body.name == "Player":
		print("spike: player detected")
		kill_player.emit()
