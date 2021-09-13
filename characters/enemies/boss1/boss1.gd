extends KinematicBody2D

export (int) var speed = 200
export (int) var jump_speed = -1200
export (int) var gravity = 4000

var state_machine

var velocity = Vector2.ZERO

var lives = 3

signal player_jump

signal level_won

func get_input():
	velocity.x = 0
	velocity.x += speed
	if velocity.x == 0:
		speed = speed * -1
	#DEBUG print(speed)
	#if Input.is_action_pressed("move_left"):
		#velocity.x -= speed
	if $raycast_left.is_colliding():
		#$CollisionShape2D.position.x *= -1
		#DEBUG print("Left")
		speed = 200
	if $raycast_right.is_colliding():
		#DEBUG print("Right")
		#DEBUG print($raycast_left.get_collider())
		speed = -200
	#if is_on_wall():
		#speed = speed * -1


func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Area2D_area_entered(_area):
	pass


func _on_enemy_top_area_entered(_area):
		lives -= 1
		$"/root/Global".Player.player_bounce()
		if lives == 0:
			print("YOU BEAT THE BOSS")
			queue_free()
			emit_signal("level_won")
		#pass
		#queue_free()
	



