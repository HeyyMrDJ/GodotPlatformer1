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
		
	if lives == 2:
		if is_instance_valid($"/root/Global".Player) and self.position.x > $"/root/Global".Player.position.x:
			yield(get_tree().create_timer(1.0), "timeout")
			speed = -250
		else:
			yield(get_tree().create_timer(1.0), "timeout")
			speed = 250
			
	if lives == 1:
		if is_instance_valid($"/root/Global".Player) and self.position.x > $"/root/Global".Player.position.x:
			yield(get_tree().create_timer(1.0), "timeout")
			speed = -250
			if is_instance_valid($"/root/Global".Player) and is_on_floor() and (self.position.y > ($"/root/Global".Player.position.y + 20)):
				velocity.y = jump_speed
				yield(get_tree().create_timer(3.0), "timeout")
		if is_instance_valid($"/root/Global".Player) and self.position.x < $"/root/Global".Player.position.x:
			yield(get_tree().create_timer(1.0), "timeout")
			speed = 250
			if is_instance_valid($"/root/Global".Player) and is_on_floor() and (self.position.y > ($"/root/Global".Player.position.y + 20)):
				velocity.y = jump_speed
				yield(get_tree().create_timer(3.0), "timeout")


	#DEBUG print(speed)
	#if Input.is_action_pressed("move_left"):
		#velocity.x -= speed
	if $raycast_left.is_colliding():
		#$CollisionShape2D.position.x *= -1
		#DEBUG print("Left")
		if lives == 3:
			speed = 200
		elif lives == 2:
			speed = 300
		elif lives == 1:
			speed = 400
		
	if $raycast_right.is_colliding():
		#DEBUG print("Right")
		#DEBUG print($raycast_left.get_collider())
		if lives == 3:
			speed = -200
		elif lives == 2:
			speed = -300
		elif lives == 1:
			speed = -400
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
		self.scale.x -= .5
		self.scale.y -= .5
		$"/root/Global".Player.player_bounce()
		if lives == 0:
			print("YOU BEAT THE BOSS")
			queue_free()
			emit_signal("level_won")
		#pass
		#queue_free()
	



