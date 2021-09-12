extends KinematicBody2D

signal level_won

func _physics_process(_delta):
	if $check_for_player.is_colliding():
		emit_signal("level_won")
		print("Level won!")
